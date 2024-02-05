import os 
import json

print("Hello")

# Folder Path 
path = "C:/Users/larad/Documents/l4project/data/packetCapture_home/quic"
  
# Change the directory 
os.chdir(path) 
  
# Read text File 
def read_text_file(file_path): 
    with open(file_path, 'r') as f: 
        print(f.read()) 
  
  
# iterate through all file 
for folder in os.listdir(): 
    print("inside " + folder)
    
    quic_folder_path = f"{path}/{folder}"
    os.chdir(quic_folder_path)

    for file in os.listdir():
        print("inside "+ file)
        # Check whether file is in text format or not 
        if file.endswith(".sqlog"): 
            qlog_file_path = f"{quic_folder_path}/{file}"
            print("file "+qlog_file_path+" has been opened")
            #os.chdir(qlog_file_path)
            # call read text file function 
            f = open(qlog_file_path, 'r')
            qlog_data = f.read()
            #parsed_data = [json.loads(line) for line in qlog_data]
            #contents = json.loads(f.read())
            print(qlog_data)

            break
        break