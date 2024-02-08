import os 
import json
import pprint
import pandas as pd
from IPython.display import display


def parseQlogFile(qlog_file_path):
    f = open(qlog_file_path, 'r')
    qlog_data = f.read()

    records = qlog_data.strip().split(regex)
    parsedRecords = parseQlogDataRecords(records)
    #data_dict = createDictionary(parsedRecords)
    pprint.pprint(parsedRecords[0])

    #df = pd.MultiIndex(levels=[['zero', 'one'], ['x','y']], labels=[[1,1,0,],[1,0,1,]])

    #df = pd.DataFrame(data_dict)
    #df = pd.concat({k: pd.DataFrame(v).T for k, v in data_dict.items()}, axis=0)

    #df = pd.DataFrame.from_dict(flat_dict, orient="index")
    #df.index = pd.MultiIndex.from_tuples(df.index)
    #df = df.unstack(level=-1)
    #df.columns = df.columns.map("{0[1]}".format)

    df = pd.DataFrame.from_dict(parsedRecords[0], orient='index')


    #df = pd.concat({k: pd.DataFrame(v).T for k, v in data_dict.items()}, axis=0)
    #fr = pd.MultiIndex.from_frame(df)

    display(df)

    f.close()
  
def parseQlogDataRecords(records):
    #records = [dict(i) for i in records if len(i) > 1]
    #print(records)
    parsed_data = [json.loads(record.strip()) for record in records]
    #pprint.pprint(parsed_data)
    return parsed_data

def createDictionary(parsed_data):
    data_dict = {}

    for data in parsed_data:
        if type(data) == dict:
            for key, value in data.items():
                if key not in data_dict:
                    data_dict[key] = [value]
                else:
                    if type(value) == dict:
                        data_dict[key].append(createDictionary(value))
                    else:
                        data_dict[key].append(value)
        else:
            return parsed_data

    
    #pprint.pprint(data_dict)
    return data_dict

regex = chr(30)

# Folder Path 
path = "C:/Users/larad/Documents/l4project/data/packetCapture_home/quic"
  
# Change the directory 
os.chdir(path) 
ctr = False
#qlog_files=0
# iterate through all file 
for folder in os.listdir(): 
    #print("inside " + folder)
    quic_folder_path = f"{path}/{folder}"
    os.chdir(quic_folder_path)

    if ctr == False:
        for file in os.listdir():
            #print("inside for")
            # Check whether file is in sqlog format or not 
            if file.endswith(".sqlog"): 
                parseQlogFile(f"{quic_folder_path}/{file}")
                #print("file "+qlog_file_path+" has been opened")
                ctr=True
                #qlog_files += 1

    
#print(qlog_files)    
    
