library(tcltk2)

minesweeper <- function(width = 20, height = 20, mines = 15) {
  # Initialize game board and timer variables
  board <- matrix(0, height, width)
  revealed <- matrix(FALSE, height, width)
  flagged <- matrix(FALSE, height, width)
  game_over <- FALSE
  first_click <- TRUE
  start_time <- NULL
  elapsed_time <- 0
  timer_running <- FALSE
  
  # Create window with timer display
  cell_size <- 30
  tt <- tktoplevel()
  tkwm.title(tt, "Minesweeper")
  
  # Create frame for timer
  timer_frame <- tkframe(tt)
  tkpack(timer_frame, side = "top", fill = "x")
  timer_label <- tklabel(timer_frame, text = "Time: 0s")
  tkpack(timer_label, side = "left", padx = 5)
  
  canvas <- tkcanvas(tt, width = width * cell_size, height = height * cell_size)
  tkpack(canvas)
  
  # Timer update function
  update_timer <- function() {
    if(timer_running && !game_over) {
      elapsed_time <<- as.integer(difftime(Sys.time(), start_time, units = "secs"))
      tkconfigure(timer_label, text = paste("Time:", elapsed_time, "s"))
      tclAfter(1000, update_timer)
    }
  }
  
  # Start timer function
  start_timer <- function() {
    if(!timer_running) {
      start_time <<- Sys.time()
      timer_running <<- TRUE
      update_timer()
    }
  }
  
  # Rest of the original functions with timer integration
  place_mines <- function(first_i, first_j) {
    safe_zone <- list()
    for(di in -1:1) {
      for(dj in -1:1) {
        ni <- first_i + di
        nj <- first_j + dj
        if(ni >= 1 && ni <= height && nj >= 1 && nj <= width) {
          safe_zone <- c(safe_zone, (ni-1)*width + nj)
        }
      }
    }
    
    available_positions <- setdiff(1:(width*height), safe_zone)
    mine_positions <- sample(available_positions, mines)
    board[mine_positions] <<- -1
    
    for(i in 1:height) {
      for(j in 1:width) {
        if(board[i,j] != -1) {
          mine_count <- 0
          for(di in -1:1) {
            for(dj in -1:1) {
              ni <- i + di
              nj <- j + dj
              if(ni >= 1 && ni <= height && nj >= 1 && nj <= width) {
                if(board[ni,nj] == -1) mine_count <- mine_count + 1
              }
            }
          }
          board[i,j] <<- mine_count
        }
      }
    }
  }
  
  draw_board <- function() {
    tkconfigure(canvas, background = "lightgray")
    for(i in 1:height) {
      for(j in 1:width) {
        x1 <- (j-1) * cell_size
        y1 <- (i-1) * cell_size
        x2 <- j * cell_size
        y2 <- i * cell_size
        
        if(!revealed[i,j]) {
          tkcreate(canvas, "rectangle", x1, y1, x2, y2, 
                   fill = "gray", outline = "white")
          if(flagged[i,j]) {
            tkcreate(canvas, "text", (x1+x2)/2, (y1+y2)/2,
                     text = "🚩", font = "{Arial} 14")
          }
        } else {
          tkcreate(canvas, "rectangle", x1, y1, x2, y2,
                   fill = "lightgray", outline = "gray")
          if(board[i,j] > 0) {
            tkcreate(canvas, "text", (x1+x2)/2, (y1+y2)/2,
                     text = board[i,j])
          } else if(board[i,j] == -1) {
            tkcreate(canvas, "text", (x1+x2)/2, (y1+y2)/2,
                     text = "💣", font = "{Arial} 14")
          }
        }
      }
    }
  }
  
  reveal_cell <- function(i, j) {
    if(i < 1 || i > height || j < 1 || j > width || revealed[i,j] || flagged[i,j]) return()
    
    if(first_click) {
      first_click <<- FALSE
      place_mines(i, j)
      start_timer()  # Start timer on first click
    }
    
    revealed[i,j] <<- TRUE
    
    if(board[i,j] == 0) {
      for(di in -1:1) {
        for(dj in -1:1) {
          reveal_cell(i + di, j + dj)
        }
      }
    } else if(board[i,j] == -1) {
      game_over <<- TRUE
      timer_running <<- FALSE  # Stop timer
      revealed <<- matrix(TRUE, height, width)
    }
  }
  
  tkbind(canvas, "<Button-1>", function(x, y) {
    if(!game_over) {
      i <- floor(as.numeric(y)/cell_size) + 1
      j <- floor(as.numeric(x)/cell_size) + 1
      reveal_cell(i, j)
      draw_board()
      
      if(game_over) {
        tkcreate(canvas, "text", width*cell_size/2, height*cell_size/2,
                 text = paste("Game Over!", elapsed_time, "s"), 
                 font = "{Arial} 20", fill = "red")
      }
    }
  })
  
  tkbind(canvas, "<Button-3>", function(x, y) {
    if(!game_over) {
      i <- floor(as.numeric(y)/cell_size) + 1
      j <- floor(as.numeric(x)/cell_size) + 1
      if(!revealed[i,j]) {
        flagged[i,j] <<- !flagged[i,j]
        draw_board()
      }
    }
  })
  
  draw_board()
}

# Start game
minesweeper()

hello <-print("Hello")
