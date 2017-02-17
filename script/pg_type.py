import re
import decimal
import datetime

decimal.getcontext().prec = 1000


def date(x):
    '''
    >>> date('12/30/2008')
    '2008-12-30'
    >>> date('31-Mar-2009')
    '2009-03-31'
    >>> date('2015-09-12')
    '2015-09-12'
    >>> date('')
    ''
    '''

    d = ''
    for fmt in ['%m/%d/%Y', '%d-%b-%Y', '%Y-%m-%d']:
        try:
            d = datetime.datetime.strptime(x, fmt).strftime('%Y-%m-%d')
        except ValueError:
            pass
        else:
            break

    return d

def boolean(x):
    return {'0': 'f', '1': 't'}[x]

def probability(x):
    p = decimal.Decimal(x)
    if 0 < p and p < 1:
        return x
    else:
        raise ValueError

def rsid(x):
    try:
        return int(x)
    except ValueError:
        return ''
