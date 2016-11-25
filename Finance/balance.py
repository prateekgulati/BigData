import httplib, urllib, base64
import json,pprint
import pandas as pd

headers = {
    # Request headers
    'Ocp-Apim-Subscription-Key': '3cf36d01b5f54ab7b204e66cc1c9da86',
}

params = urllib.urlencode({
    # Request parameters
    'formType': '10-K',
    'filingOrder': '0',
})

try:
    conn = httplib.HTTPSConnection('services.last10k.com')
    conn.request("GET", "/v1/company/GOOGL/balancesheet?%s" % params, "{body}", headers)
    response = conn.getresponse()
    data = json.loads(response.read())
    col1=[]
    col2=[]
    #pprint.pprint(data['Data'])
    for i in data['Data']:
        col1.append(i)
        col2.append(data['Data'][i])
        print(i,data['Data'][i])
    df=pd.DataFrame(zip(col1,col2))
    #print(df)
    
    df.to_csv('balance_sheet.csv')
    conn.close()
except Exception as e:
    print(e)