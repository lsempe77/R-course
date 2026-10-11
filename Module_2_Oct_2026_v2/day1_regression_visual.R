day1_binary_fit_svg <- function(means, labels, axis_label, equation) {
  stopifnot(length(means)==2, length(labels)==2, all(is.finite(means)))
  x <- c(240, 820)
  top <- ceiling(max(means)/500)*500
  y <- function(value) 250-value/top*180
  ticks <- seq(0, top, by=500)
  grid <- paste(vapply(ticks, function(value) sprintf(
    '<line x1="160" x2="960" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="145" y="%.1f" text-anchor="end" font-size="21">%s</text>',
    y(value), y(value), y(value)+7, format(round(value), big.mark=',', trim=TRUE)), ''), collapse='')
  paste0('<svg class="review-svg" viewBox="0 0 1100 370" role="img" aria-label="',
    axis_label, ': fitted group means. Intercept ',round(means[1]),
    ' AED; slope ',round(diff(means)),' AED for a change from zero to one.">',
    '<text x="160" y="25" font-size="23">Fitted mean annual waste cost (AED per business)</text>',grid,
    sprintf('<line x1="%s" x2="%s" y1="%.1f" y2="%.1f" stroke="#215a9e" stroke-width="5"/>',
      x[1],x[2],y(means[1]),y(means[2])),
    paste(sprintf('<circle cx="%s" cy="%.1f" r="8" fill="#063360"/><text x="%s" y="%.1f" font-size="23" text-anchor="middle">%s AED</text>',
      x,y(means),x,y(means)-16,format(round(means),big.mark=',',trim=TRUE)),collapse=''),
    sprintf('<line x1="900" x2="900" y1="%.1f" y2="%.1f" stroke="#B8272C" stroke-width="4"/><text x="917" y="%.1f" font-size="22" fill="#B8272C">Slope</text><text x="917" y="%.1f" font-size="22" fill="#B8272C">%s AED</text>',
      y(means[1]),y(means[2]),mean(y(means))-8,mean(y(means))+18,
      format(round(diff(means)),big.mark=',',trim=TRUE)),
    paste(sprintf('<text x="%s" y="282" text-anchor="middle" font-size="23">%s</text>',x,labels),collapse=''),
    '<text x="240" y="311" text-anchor="middle" font-size="22">Intercept: fitted mean at 0</text>',
    '<text x="820" y="311" text-anchor="middle" font-size="22">Intercept + slope: fitted mean at 1</text>',
    '<text x="550" y="354" text-anchor="middle" font-size="24" fill="#063360">',equation,'</text></svg>')
}
