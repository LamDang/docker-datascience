$([IPython.events]).on('app_initialized.NotebookApp', function(){                                                                     
        IPython.notebook.events.on('received_unsolicited_message.Kernel', function(evt, data) {                                         
        cells = IPython.notebook.get_cells();                                                                                         
                for (i = 0; i < cells.length; i++)                                                                                    
                {                                                                                                                     
                        if (cells[i].output_area != undefined)                                                                        
                        {                                                                                                             
                                cells[i].output_area.handle_output(data);                                                             
                                break;                                                                                                
                        }                                                                                                             
                }                                                                                                                     
        });                                                                                                                           
});
