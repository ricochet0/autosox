## autosox
This script recursively traverses a directory and creates spectrograms of the audio files.  

#### Usage  
To create a collection of spectrograms in the current directory, run  
```bash path/to/autosox.sh DIR```  
Where DIR contains your audio files

#### Dependencies
- [sox](http://sox.sourceforge.net/)  
- [imagemagick](https://imagemagick.org/index.php)  

#### Tip
Add the following line to ~/.bashrc:  
```alias autosox='bash absolute/path/to/autosox.sh'```  
That way you can run  
    autosox DIR  
from anywhere
