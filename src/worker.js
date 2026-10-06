// The 3ie.academy Worker: the shared-password gate in front of the static site.
//
// The site itself is the docs/ folder, served as Worker static assets (see
// wrangler.jsonc, run_worker_first: true, so every request comes here first).
// The gate logic lives in functions/_middleware.js and is shared with the
// Cloudflare Pages version; here "next" means "serve the file from docs/".

import { onRequest } from "../functions/_middleware.js";

export default {
  async fetch(request, env) {
    return onRequest({ request, env, next: () => env.ASSETS.fetch(request) });
  },
};
