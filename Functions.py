import numpy as np
import pandas as pd

k = 6

a2 = np.array([0,0.5,3,9,99,99])
b3 = np.array([6.42,6.42,6.42,6.42,6.42,6.42])

def A1(sm):
    return pd.Series([np.prod(sm.T.iloc[:j+1])*(-1)**(j+1) for j in range(k)]).sum()

def A2(sm):
    return pd.Series([(np.abs(4*sm[j]-2)+a2[j])/(1+a2[j]) for j in range(k)]).product()

def A2b(sm,sn):
    return pd.Series([(np.abs(4*(sm[j]+sn[j]-np.modf(sm[j]+sn[j])[1])-2)+a2[j])/(1+a2[j]) for j in range(k)]).product()

def B1(sm):
    return pd.Series([(k-sm[j])/(k-0.5) for j in range(k)]).product()
        
def B2(sm):
    return ((1+1/k)**k)*pd.Series([sm[j]**(1/k) for j in range(k)]).product()
        
def B3(sm):
    return pd.Series([(np.abs(4*sm[j]-2)+b3[j])/(1+b3[j]) for j in range(k)]).product()
        
def C1(sm):
    return pd.Series([np.abs(4*sm[j]-2) for j in range(k)]).product()
        
def C2(sm):
    return sm.product(axis=1)*2**k

