$([IPython.events]).on('app_initialized.NotebookApp', function(){
      IPython.notebook.events.on('received_unsolicited_message.Kernel', function(evt, data) {
        cells = IPython.notebook.get_cells();
        cells[0].output_area.handle_output(data)
        }); 
});

