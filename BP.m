p = [-6.0 -6.1 -0 -0 +4.0 0 0 0];
t = [+0.0 +0.0 +.97 +.99 +.01 +.03 +1.0 +1.0];
wv = -5:.1:5; bv = -5:.25:5;
es = errsurf(p,t,wv,bv,'logsig');
plotes(wv,bv,es,[60 30])