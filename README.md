# mp3-converter
Simple powershell script to convert various audio files to mp3 using ffmpeg.
ffmpeg is required for the script to function. (duh)
You'll need to modify the $Path variable in the parameters to the path of your folder containing audio files, or pass it in as an argument.
The same is true for the file extensions and default output.
If you run into an access denied issue when trying to run the script, changing the execution policy in powershell to RemoteSigned worked for me, with the command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned".
