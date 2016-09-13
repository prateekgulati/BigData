__author__ = 'Prateek'
'''
Run KMeans.py
'''

import pandas
import sys
import numpy

def kMeans(filename,k,lower,upper):
    df=pandas.read_csv(filename,names=['x','y'])
    cluster = pandas.DataFrame(lower+numpy.random.random([k,2])*(upper-lower), columns=list('xy'))
    distance=pandas.DataFrame()
    iter=5
    for iterations in range(iter):
        i=0
        for x,y in cluster.values:
            i+=1
            distance[i]=(df.x- x)**2+(df.y- y)**2
            df[iterations]=distance.idxmin(axis=1)
        cluster=df.groupby(iterations).mean()[['x','y']]
    return df


if __name__ == '__main__':
    try:
        filename=sys.argv[1]
    except:
        filename='Data.csv'
    try:
        K=int(sys.argv[2])
    except:
        K=3
    try:
        lower=float(sys.argv[3])
    except:
        lower=0.0
    try:
        upper=float(sys.argv[4])
    except:
        upper=10.0
    df=kMeans(filename,K,lower,upper)
    df.to_csv('clustered.csv',index=False)