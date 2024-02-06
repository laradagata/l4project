import os 
import json
import pprint
import pandas as pd


def parseQlogFile(qlog_file_path):
    f = open(qlog_file_path, 'r')
    qlog_data = f.read()

    records = qlog_data.strip().split(regex)
    parsedRecords = parseQlogDataRecords(records)
    data_dict = createDictionary(parsedRecords)

    #df = pd.DataFrame(data_dict)
    #df = pd.concat({k: pd.DataFrame(v).T for k, v in data_dict.items()}, axis=0)
    flat_dict = flatten_dict(data_dict)

    #df = pd.DataFrame.from_dict(flat_dict, orient="index")
    #df.index = pd.MultiIndex.from_tuples(df.index)
    #df = df.unstack(level=-1)
    #df.columns = df.columns.map("{0[1]}".format)

    df = pd.DataFrame.from_dict(data_dict, orient='index')
    #df = pd.concat({k: pd.DataFrame(v).T for k, v in data_dict.items()}, axis=0)

    print(df.T)

    f.close()

def flatten_dict(nested_dict):
    res = {}
    if isinstance(nested_dict, dict):
        for k in nested_dict:
            flattened_dict = flatten_dict(nested_dict[k])
            for key, val in flattened_dict.items():
                key = list(key)
                key.insert(0, k)
                res[tuple(key)] = val
    else:
        res[()] = nested_dict
    return res
  
def parseQlogDataRecords(records):
    #records = [dict(i) for i in records if len(i) > 1]
    #print(records)
    parsed_data = [json.loads(record.strip()) for record in records]
    #pprint.pprint(parsed_data)
    return parsed_data

def createDictionary(parsed_data, data_dict={}):
    #data_dict = {}

    for data in parsed_data:
        for key, value in data.items():
            if key not in data_dict:
                data_dict[key] = [value]
            else:
                data_dict[key].append(value)
    
    #pprint.pprint(data_dict)
    return data_dict

regex = chr(30)

# Folder Path 
path = "C:/Users/larad/Documents/l4project/data/packetCapture_home/quic"
  
# Change the directory 
os.chdir(path) 

# iterate through all file 
for folder in os.listdir(): 
    #print("inside " + folder)
    quic_folder_path = f"{path}/{folder}"
    os.chdir(quic_folder_path)

    for file in os.listdir():
        #print("inside "+ file)
        # Check whether file is in sqlog format or not 
        if file.endswith(".sqlog"): 
            parseQlogFile(f"{quic_folder_path}/{file}")
            #print("file "+qlog_file_path+" has been opened")
            break
        break
    
    