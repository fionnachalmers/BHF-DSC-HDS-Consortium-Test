observeEvent(input$add, {
  removeUI(
    selector = "#message_temp"
  )
})




input_counter <- reactiveVal(1) 

handlers <- reactiveVal(list()) #holds all reactives of the module
observers <- list() #create (and delete) observers for the kill switch

n <- 1
inputcounter <- reactiveVal(1)

get_event <- reactive({
  input$events
})

observeEvent(input$add, {
  id <- paste0("row_", n)
  n <<- n + 1
  
  insertUI("#Panels",
           "beforeEnd",
           datasetUI(id=id)
           
  )
  

  
  new_handler <- setNames(list(callModule(datasetServer,
                                          id,
                                          no=n,
                                          get_event)),
                          id)
  handler_list <- c(handlers(), new_handler)
  handlers(handler_list)
})


observe({
  hds <- handlers()
  req(length(hds) > 0)
  new <- setdiff(names(hds),
                 names(observers))
  
  obs <- setNames(lapply(new, function(n) {
    observeEvent(hds[[n]]$delete(), { #remove the handler from the lists and remove the corresponding html
      removeUI(paste0("#", n))
      hds <- handlers()
      hds[n] <- NULL
      handlers(hds)
      observers[n] <<- NULL
    }, ignoreInit = TRUE)
  }), new)
  
  observers <<- c(observers, obs)
})

table1 <- reactive({
  hds <- req(handlers())
  req(length(hds) > 0)
  tbl_list <- lapply(hds, function(h) {
    h$get_data()
  })
  do.call(rbind, tbl_list)
})


input_colours = data.frame(input_no = 2:1000) %>%
  add_column(colours = rep(compare_palette, length.out=nrow(.)))


table2 <- reactive({table1() %>% left_join(input_colours,by=c("number"="input_no"))})


#WORKS
# table2 <- reactive({
#   #req(counter$countervalue <=2)
#   if(counter$countervalue <=2){
#       table1() %>% left_join(input_colours,by=c("number"="input_no"))
#   } else {
#     table1() %>% mutate(colours = xvals())
#     }
# })

# table2 <- reactive({
#   if(counter$countervalue >2){
#     table1() %>% left_join(input_colours,by=c("number"="input_no"))}
# })


# table2 <- reactive({
#   #req(counter$countervalue <=2)
#   if(counter$countervalue <=2){
#       table1() %>% left_join(input_colours,by=c("number"="input_no"))
#   }
# })
# 
# 
# observeEvent(req(input$add, counter$countervalue >2), {
#   table2 <- reactive({table1() %>% mutate(colours = xvals())})
# })



#set_colours <- reactive({table2() %>% select(colours) %>% pull()})
#set_row_numbers <- reactive({table2() %>% select(number) %>% pull()})

# memory <- reactiveValues(previous_colours = NULL)
# colours_list <- reactive({ table2() %>% pull(colours) })
# 
# xvals <- reactive({
#   isolate(previous_colours <- memory$previous_colours)
#   if (is.null(previous_colours)) {
#     memory$previous_colours <- c(colours_list())
#   } else {
#     memory$previous_colours <- c(previous_colours,colours_list())
#   }
#   return(memory$previous_colours)
# })
# 
# observe({print(xvals())
#   print(table2())
#   
#   })



  
table3 <- reactive({table2()})


# # Initialize reactive values
# rv <- reactiveValues(previous_colours = "white")
# 
# # Append new value to previous values when input$bins changes 
# 
# rv$revious_colours <- reactive({c(rv$revious_colours, table3() %>% head(1) %>% pull(colours))})
# 
# 
# # Output
# observe({
#   paste(rv$prev_bins)
# })



# previous <- reactiveValues(previous_colours = "white",
#                            previous_numbers = 1)
# observeEvent(req(set_colours()), {
#   previous$previous_colours <- c(previous$previous_colours, "white", set_colours())
# })
# observeEvent(req(set_row_numbers()), {
#   previous$previous_numbers <- c(previous$previous_numbers, 1, set_row_numbers())
# })
# observeEvent(previous$previous_numbers, {
#   previous$datatable <- data.frame(colours=previous$previous_colours,number=previous$previous_numbers)
# })
# observe({
#   #print(previous$previous_colours)
#   #print(previous$previous_numbers)
#   print(previous$datatable)
#   })
# observeEvent(input$add, {
#   previous$datatable <- data.frame(colours=previous$previous_colours,number=previous$previous_numbers)
# })











# table3 <- reactive({
# table2() %>%
#       mutate(colours = ifelse(row_number() == n() &
#                                 length(setdiff(
#                                   compare_palette[1:nrow(table2())],
#                                   pull(table2() %>% select(colours))
#                                 ))!=0,
#                               
#                               setdiff(compare_palette[1:nrow(table2())],pull(table2() %>% select(colours))),
#                               colours))
# })


# table3 <- reactive({
#   req(input$add)
#   if (input$add) {
#     data <- table2() %>%
#       mutate(colours = ifelse(row_number() == n() &
#                                 length(setdiff(
#                                   compare_palette[1:nrow(table2())],
#                                   pull(table2() %>% select(colours))
#                                 ))!=0,
#                               
#                               setdiff(compare_palette[1:nrow(table2())],pull(table2() %>% select(colours))),
#                               colours))
#   }
#   else
#   {
#     data <- table2() %>%
#       mutate(colours = ifelse(row_number() == n() &
#                                 length(setdiff(
#                                   compare_palette[1:nrow(table2())],
#                                   pull(table2() %>% select(colours))
#                                 ))!=0,
#                               
#                               setdiff(compare_palette[1:nrow(table2())],pull(table2() %>% select(colours))),
#                               colours))
#   }
#   
#   
# })


# table3 <- reactive({
#   req(input$add)
#   if (!input$add) {
#     data <- table1() %>% left_join(input_colours,by=c("number"="input_no"))
#   }
#   else
#   {
#     data <- table1() %>% left_join(input_colours,by=c("number"="input_no"))
#   }
#   
#   
# })


# table3  <- eventReactive(input$add,{
#   table2() %>% 
#     mutate(colours = ifelse(row_number() == n() & 
#                               length(setdiff(
#                                 compare_palette[1:nrow(table2())],
#                                 pull(table2() %>% select(colours))
#                               ))!=0,
#                             
#                             setdiff(compare_palette[1:nrow(table2())],pull(table2() %>% select(colours))),
#                             colours))
# })

#output$reactive_test_table = renderTable(table3())




#output$reactive_test = renderPrint(reactiveValuesToList(input))

compare_palette_values = reactive({setNames(table3()%>%pull(colours),table3()%>%pull(dataset))})

output$test = renderPrint(table1() %>% pull(dataset))

my_vars = reactive({table1() %>% pull(dataset)})





  
  

compare_coverage_data_all_records_before =  reactive({
  t.data_coverage %>%
    left_join(datasets_available,by = c("dataset"="Dataset")) %>%
    
    #filter(.data$dataset %in% reactiveValuesToList(input)) %>%
    
    filter(.data$dataset %in% my_vars()) %>%
    
    #tooltips for plot
    mutate(N_tooltip = format(.data$N, nsmall=0, big.mark=",", trim=TRUE)) %>%
    mutate(N_tooltip_date = paste0(date_name,N_tooltip)) %>%
    mutate(N_tooltip_date_season = paste0(date_name_season,N_tooltip))
})
    
compare_coverage_data_all_records =  reactive({ 
  compare_coverage_data_all_records_before() %>%
    #filter(Type == input$type_compare) %>%
    ungroup()
})

compare_coverage_data_start_date =
  reactive({
    compare_coverage_data_all_records() %>%
      #filter date range
      mutate(start_date = as.Date(paste(start_date, 1, sep="-"), "%Y-%m-%d")) %>%
      #to ensure all datasets take the min start date of the greatest min
      mutate(start_date = min(start_date))%>%
      filter(!start_date >= date_format) %>%
      #using current month but this should be updated to use production ym in future
      mutate(current_date = as.Date(paste(format(Sys.Date(), "%Y-%m"), 1, sep="-"), "%Y-%m-%d")) %>%
      filter(date_format <= current_date) %>%
      ungroup()
  })

compare_coverage_data = reactive({
  if(input$all_records) {
    (compare_coverage_data_all_records())
  } else {
    (compare_coverage_data_start_date())
  }
})

#observe min and max years available for slider input
compare_date_range_coverage_extremum2 = reactive({
  compare_coverage_data() %>%
    summarise(min = min(.data$date_y),
              max = max(.data$date_y)) %>%
    pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
})

compare_date_range_coverage_min2 = reactive({compare_date_range_coverage_extremum2() %>% filter(.data$extremum=="min") %>% pull(year)})
compare_date_range_coverage_max2 = reactive({compare_date_range_coverage_extremum2() %>% filter(.data$extremum=="max") %>% pull(year)})

compare_date_range_coverage_extremum_start_date2 = reactive({
  compare_coverage_data_start_date() %>%
    summarise(min = min(.data$date_y),
              max = max(.data$date_y)) %>%
    pivot_longer(cols=c(min,max),names_to="extremum",values_to="year")
})

compare_date_range_coverage_min_start_date2 = reactive({compare_date_range_coverage_extremum_start_date2() %>% filter(.data$extremum=="min") %>% pull(year)})
compare_date_range_coverage_max_start_date2 = reactive({compare_date_range_coverage_extremum_start_date2() %>% filter(.data$extremum=="max") %>% pull(year)})




observe({
  updateSliderInput(session, "date_range_coverage2",
                    min = compare_date_range_coverage_min2(),
                    max = compare_date_range_coverage_max2(),
                    value = c(
                      compare_date_range_coverage_min_start_date2(),
                      compare_date_range_coverage_max_start_date2()
                    ),
                    step=1
  )})



#date filtered dataset
compare_coverage_data_filtered = reactive({
  
  #to stop error message flashing up on screen - ensure date range has updated before computing
  validate(
    need(input$date_range_coverage2, message = FALSE)
  )
  
  compare_coverage_data() %>%
    filter(.data$date_y>=input$date_range_coverage2[1] & .data$date_y<=input$date_range_coverage2[2]) %>%
    filter(Type == input$type_compare)
})


y_axis = reactive({paste((if(input$type_compare=="n_id_distinct"){"Monthly Distinct IDs"} else if (input$type_compare=="n_id"){"Monthly Valid IDs"} else {"Monthly Records"}),
                         ifelse(input$log_scale,"(Log Scale)","(Linear Scale)"))})

## Trend Plot ============================================================

validate_plots = reactive({compare_coverage_data_filtered() %>% distinct(dataset) %>% select(dataset)})

compare_coverage_plot = reactive({
  
  #dont render until have 2 datasets
  validate(
    need(nrow(validate_plots()) > 1, message = FALSE)
  )

  ggplot(
    data = compare_coverage_data_filtered(),
    aes(x = .data$date_format,
        if(input$log_scale){y=.data$N} else {y=.data$N},
        color = .data$dataset,
        data_id = .data$dataset,
        group = .data$dataset
    )
  ) +
    geom_line_interactive(size = 3,
              alpha = if(input$trend_line){0.1} else {0.4},
              aes(
                  data_id = .data$dataset
              )) +
    geom_point_interactive(
      aes(tooltip = .data$N_tooltip_date),
      alpha = if(input$trend_line){0.2} else {0.8},
      fill = "white",
      size = 3,
      stroke = 1.5,
      shape = 20) +
    
    {if(input$trend_line)geom_smooth_interactive(aes(fill = .data$dataset,
                                                     tooltip = .data$N_tooltip_date), method="auto", se=TRUE, fullrange=FALSE, level=0.95)} +
    
    #coord_trans(y="log10") +
    labs(x = NULL, y = y_axis()) +
    theme_minimal() +
    theme(
      text=element_text(family=family_lato),
      panel.grid = element_blank(),
      plot.margin = margin(10,50,0,0),
      plot.background = element_rect(color=NA),
      panel.background = element_rect(color = NA),
      axis.ticks = element_blank(),
      axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size = 12, color="#4D4C4C"),
      axis.text.x = element_text(size = 14, face = "bold"),
      axis.text.y = element_text(size = 13, face = "bold"),
      legend.position = "none"
    ) +
    
    scale_colour_manual(values=compare_palette_values(), name = "colour_compare") +
    scale_fill_manual(values=compare_palette_values(), name = "colour_compare")  +

    coord_cartesian(clip = "off") +

    scale_y_continuous(labels = scales::label_number_si(), #limits = c(0, NA),
                       trans=if(input$log_scale){scales::pseudo_log_trans(base = 10)} else {trend="identity"}
                       ) 
    
})



y_nudge = reactive({(
  #nudge up a 30th of difference between max and min
  (
    (
      (
        compare_coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
          compare_coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
    ) /30)
)})

y_nudge_log = reactive({(
  #nudge up a 30th of difference between max and min
  (
    (
      (
        log(compare_coverage_data_filtered() %>% mutate(N=log(N)) %>% filter(N == max(N)) %>% distinct(N) %>% pull(N))) - (
          log(compare_coverage_data_filtered() %>% mutate(N=log(N)) %>% filter(N == min(N)) %>% distinct(N) %>% pull(N)))
    ) /30)
)})

x_nudge = reactive({
  (
    as.numeric(
      (compare_coverage_data_filtered() %>% filter(date_format == max(date_format)) %>% distinct(date_format) %>% pull(date_format)) -
        (compare_coverage_data_filtered() %>% filter(date_format == min(date_format)) %>% distinct(date_format) %>% pull(date_format))
    )/10)
})



output$compare_coverage_plot_girafe = 
  renderGirafe({
    
    validate(
      need(nrow(validate_plots()) > 1, message = FALSE)
    )
    
    #validate(need(compare_coverage_plot(), "")) #attempt to only induce spinner once 2 inputs added
    
  girafe(ggobj = compare_coverage_plot() +
           
           (geom_text_repel_interactive(
             size = 6,
             data = (
               compare_coverage_data_filtered() %>% 
                 filter(date_format == max(date_format))
             ),
             
             aes(
               x = .data$date_format + x_nudge(),
               y = if(input$log_scale){(.data$N) } else {.data$N + (
                 #nudge up a 30th of difference between max and min
                 (
                   (
                     (
                       compare_coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                         compare_coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                   ) /30)
               )},
               color = .data$dataset,
               label = .data$Shortname
             ),
             
             direction = "y",
             family=family_lato,
             segment.color = 'transparent'))
         
         ,
         width_svg = 16,
         height_svg = 9,
         options = list(
           opts_tooltip(
             opacity = 0.95, #opacity of the background box
             css = "background-color:#EC2154;
            color:white;font-size:10pt;font-style:italic;
            padding:5px;border-radius:10px 10px 10px 10px;"
           ),
           #to work - need data_id on
           opts_hover_inv(
             css = "opacity:0.2; transition-delay:0.2s;"#stroke-width:3; #delaying slightly so that when running over points doesnt look glitchy
           ),
           opts_hover(
             css = if(input$trend_line){"opacity: 1; transition-delay:0.2s;"} else {"opacity: 1; transition-delay:0.2s;"} 
           ),
           #turn off save as png as will put this as a shiny command to match excel download
           opts_toolbar(saveaspng = FALSE),
           opts_selection(type="none")
         )
  )
})



observeEvent(input$download_coverage_data, {
  
  shinyalert::shinyalert("Export Data:", 
             type = "info",
             size = "xs",
             html = TRUE,
             text = tagList(
               #textInput(inputId = "namere", label = NULL),
               selectInput(inputId = "download_choice_compare", choices=c("with selected plot input"="selected","in full"="full"), label=NULL),
               downloadButton("confName", "Confirm")
             ),
             closeOnEsc = TRUE,
             closeOnClickOutside = TRUE,
             showConfirmButton = FALSE,
             showCancelButton = FALSE,
             animation = TRUE
  )
  runjs("
        var confName = document.getElementById('confName')
        confName.onclick = function() {swal.close();}
        ")
  
})



output$confName = downloadHandler(
  filename = function() {if(input$download_choice_compare=="selected"){
    paste0("data_coverage_",str_remove_all(Sys.Date(),"-"),".xlsx")} else {
      paste0("data_coverage_full_",str_remove_all(Sys.Date(),"-"),".xlsx")}
  },
  content = function(file) {writexl::write_xlsx(
    
    if(input$download_choice_compare=="selected"){
      t.data_coverage_source %>%
        arrange(dataset,date_ym) %>%
        left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
        filter(.data$dataset %in% my_vars()) %>%
        ungroup() %>%
        mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
        filter(!is.na(date_ym)) %>%
        separate(date_ym, c("date_y", "date_m"), remove=FALSE, sep = '-') %>%
        mutate(across(.cols = c(date_y, date_m), .fn = ~ as.numeric(.))) %>%
        filter(.data$date_y>=input$date_range_coverage2[1] & .data$date_y<=input$date_range_coverage2[2]) %>%
        select(dataset,title, date_ym, any_of(input$type_compare)) %>%
        mutate(export_date = Sys.Date())
      } else {t.data_coverage_source %>%
          arrange(dataset,date_ym) %>%
          left_join(datasets_available%>%select(dataset=Dataset,title=Title),by = c("dataset")) %>%
          filter(.data$dataset %in% my_vars()) %>%
          ungroup() %>%
          mutate(date_ym = ifelse(date_ym=="", NA, date_ym)) %>%
          filter(!is.na(date_ym)) %>%
          select(dataset,title, date_ym, n, n_id, n_id_distinct) %>%
          mutate(export_date = Sys.Date())},
    format_headers = FALSE,
    path=file)}
)




output$download_compare_coverage_plot = downloadHandler(
  filename = function() {paste0("compare_data_coverage_",str_remove_all(Sys.Date(),"-"),".png")},
  content = function(file) {ggsave(file, plot = (compare_coverage_plot()) +

                                     #add geom text layer separate for girafe object and download as different sizes needed
                                     (geom_text_repel_interactive(
                                       size = 12,
                                       data = (
                                         compare_coverage_data_filtered() %>% 
                                           filter(date_format == max(date_format))
                                       ),
                                       
                                       aes(
                                         x = .data$date_format + x_nudge(),
                                         y = if(input$log_scale){(.data$N) } else {.data$N + (
                                           #nudge up a 30th of difference between max and min
                                           (
                                             (
                                               (
                                                 compare_coverage_data_filtered() %>% filter(N == max(N)) %>% distinct(N) %>% pull(N)) - (
                                                   compare_coverage_data_filtered() %>% filter(N == min(N)) %>% distinct(N) %>% pull(N))
                                             ) /30)
                                         )},
                                         color = .data$dataset,
                                         label = .data$Shortname
                                       ),
                                       
                                       direction = "y",
                                       family=family_lato,
                                       segment.color = 'transparent')) +
                                     
                                     #custom theme for download
                                     theme(plot.margin = margin(20,50,20,50),
                                           axis.text.x = element_text(size = 34, face = "bold"),
                                           axis.text.y = element_text(size = 34, face = "bold"),
                                           axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0), face = "bold", size=34, color="#4D4C4C")
                                     ),
                                   #ensure width and height are same as ggiraph
                                   #width_svg and height_svg to ensure png not cut off
                                   width = 16, height = 9, units = "in",
                                   bg = "transparent",
                                   dpi = 300, device = "png")}
)






# observeEvent(req(counter$countervalue>0, input$"row_1-delete"), {
#   insertUI(
#     selector = "#Panels",
#     where = "beforeBegin",
#     ui = div(id = paste0("txt", input$add),
#         h6("Click below to begin comparing datasets:"))
#   )
# })
# 
# 
# observeEvent(req(counter$countervalue > sum(input$"row_1-delete")), {
#   removeUI(
#     selector = "div:has(> #txt)"
#   )
# })

observe({
# print(input$"row_1-dataset_compare")
# print(is.null(input$"row_1-dataset_compare"))
# print(!is.null(input$"row_1-dataset_compare"))
# print(names(input))
# print(is.null(input_counter()))
# print(input$delete)
# print(is.null(input$delete))
# print(names(input))
# print(str_count(paste(names(input),collapse=""),"-delete"))

# print(counter$countervalue)
#   print(table1())
#   print(table2())
#   print(table3())
  #print(length((reactiveValuesToList(input))[grep('-dataset_compare', names((reactiveValuesToList(input))))]))
  #print((reactiveValuesToList(input)))
# print(if(length((reactiveValuesToList(input))[grep('-dataset_compare', names((reactiveValuesToList(input))))])>=2){
#   data.frame((reactiveValuesToList(input))[grep('-dataset_compare', names((reactiveValuesToList(input))))]) %>% pivot_longer()
#   })
#print(table1() %>% left_join(input_colours,by=c("number"="input_no")))
#print(compare_palette_values)
})


#Add Button click counter
counter <- reactiveValues(countervalue = 0)
observeEvent(req(input$add), {
  counter$countervalue <- counter$countervalue + 1
  })

# observe({
# print(counter$countervalue)
# print(counter$countervalue > sum(input$"row_1-delete"))
#  })


