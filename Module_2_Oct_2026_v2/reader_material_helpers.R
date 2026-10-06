out_handouts <- '../docs/handouts'
dir.create(out_handouts, recursive = TRUE, showWarnings = FALSE)
set_flextable_defaults(font.family = 'Arial', font.size = 12, padding = 7,
                       border.color = '#D9D9D9')
rdoc <- function() {
  read_docx('reader_template.docx') |> body_set_default_section(prop_section(
    page_size=page_size(width=8.27,height=11.69),
    page_margins=page_mar(top=.65,bottom=.65,left=.7,right=.7)))
}
rp <- function(d, text, size=12, bold=FALSE, colour='black', after=8) {
  body_add_fpar(d, fpar(ftext(text, fp_text(font.family='Arial',font.size=size,bold=bold,color=colour)),
                       fp_p=fp_par(padding.bottom=after)))
}
rt <- function(d, title, session) {
  d <- rp(d, paste('GreenWaste reading workshop | Day', reader_day, '| Session', session), 10, colour='#545860',after=3)
  body_add_fpar(d, fpar(ftext(title,fp_text(font.family='Arial',font.size=22,bold=TRUE,color='black'))), style='Title')
}
rh <- function(d, text) rp(d,text,14,TRUE,after=6)
rl <- function(d, n=2) {for (i in seq_len(n)) d <- rp(d,strrep('_',55),12,colour='#B5BEC9',after=12); d}
rf <- function(d) rp(d,'GreenWaste is a fictional training case.',9,colour='#545860',after=8)
rtable <- function(df, widths) {
  ft <- flextable(df) |> fontsize(size=12,part='all') |> font(fontname='Arial',part='all') |>
    bg(bg='#063360',part='header') |> color(color='white',part='header') |> bold(part='header') |>
    border_remove() |> border_outer(border=fp_border(color='#D9D9D9',width=.75)) |>
    border_inner(border=fp_border(color='#D9D9D9',width=.75)) |>
    width(width=widths) |> padding(padding=7,part='all') |> valign(valign='center',part='all') |>
    align(align='left',part='all') |> set_table_properties(layout='fixed',align='left')
  if (nrow(df)>1) ft <- bg(ft,i=seq(2,nrow(df),2),bg='#F1F5F9',part='body')
  ft
}
