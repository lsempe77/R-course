// Shared-password gate for the whole site (Cloudflare Pages Functions).
//
// Every request to 3ie.academy passes through here. A visitor without the
// cookie gets a small login page; the right password sets a cookie for 30 days.
// The password is the Pages secret SITE_PASSWORD (Settings > Variables and
// Secrets), never stored in this repository. Changing the secret logs everyone
// out, because the cookie is derived from it.

const COOKIE = "m2_auth";
const MAX_AGE = 60 * 60 * 24 * 30;   // 30 days

async function tokenFor(password) {
  const data = new TextEncoder().encode("3ie-academy:" + password);
  const hash = await crypto.subtle.digest("SHA-256", data);
  return [...new Uint8Array(hash)].map(b => b.toString(16).padStart(2, "0")).join("");
}

// Only same-site paths are allowed as the page to return to after login.
function safePath(p) {
  return typeof p === "string" && p.startsWith("/") && !p.startsWith("//") ? p : "/";
}

function loginPage(next, failed) {
  const html = `<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>3ie Academy</title>
<style>
  :root { --ink:#111418; --muted:#545860; --accent:#215a9e; --dark:#063360; --alert:#B8272C; --rule:#D5DEE8; }
  * { box-sizing: border-box; }
  body { margin:0; min-height:100vh; display:grid; place-items:center; background:#f4f7fb;
         font-family:"Segoe UI", system-ui, -apple-system, Arial, sans-serif; color:var(--ink); }
  main { width:min(380px, calc(100% - 32px)); background:#fff; border:1px solid var(--rule);
         border-top:5px solid var(--accent); border-radius:8px; padding:28px 26px; }
  h1 { margin:0 0 4px; font-size:1.35rem; color:var(--dark); }
  p { margin:0 0 18px; color:var(--muted); font-size:.95rem; }
  label { display:block; font-size:.85rem; color:var(--muted); margin-bottom:6px; }
  input { width:100%; padding:10px 12px; font-size:1rem; border:1px solid var(--rule); border-radius:6px; }
  input:focus { outline:2px solid var(--accent); outline-offset:1px; }
  button { margin-top:14px; width:100%; padding:10px; font-size:1rem; font-weight:600; color:#fff;
           background:var(--accent); border:0; border-radius:6px; cursor:pointer; }
  .err { color:var(--alert); font-size:.9rem; margin:10px 0 0; }
</style></head>
<body><main>
  <h1>Module 2 materials</h1>
  <p>Reading Impact Evaluation Results · 3ie</p>
  <form method="post" action="/__login">
    <label for="pw">Password</label>
    <input id="pw" name="password" type="password" autocomplete="current-password" autofocus required>
    <input type="hidden" name="next" value="${next.replace(/"/g, "&quot;")}">
    <button type="submit">Open</button>
    ${failed ? '<p class="err">That password is not right. Try again.</p>' : ""}
  </form>
</main></body></html>`;
  return new Response(html, {
    status: 401,
    headers: { "content-type": "text/html; charset=utf-8", "cache-control": "no-store" },
  });
}

export async function onRequest({ request, env, next }) {
  const password = env.SITE_PASSWORD;
  if (!password) return new Response("The site password has not been set.", { status: 500 });

  const url = new URL(request.url);
  const expected = await tokenFor(password);

  if (url.pathname === "/__login" && request.method === "POST") {
    const form = await request.formData();
    const back = safePath(form.get("next"));
    if ((form.get("password") || "") === password) {
      return new Response(null, {
        status: 303,
        headers: {
          Location: back,
          "Set-Cookie": `${COOKIE}=${expected}; Path=/; Max-Age=${MAX_AGE}; HttpOnly; Secure; SameSite=Lax`,
        },
      });
    }
    return loginPage(back, true);
  }

  const cookies = (request.headers.get("Cookie") || "").split(/;\s*/);
  if (cookies.includes(`${COOKIE}=${expected}`)) return next();

  return loginPage(url.pathname + url.search, false);
}
