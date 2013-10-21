from pymatbridge import Matlab
import os
import scipy.io

if __name__ == "__main__":
    config = {}
    execfile("settings.conf", config) 
    # python 3: exec(open("example.conf").read(), config)
    mlab=Matlab(matlab=config['MATLAB_LOCATION'])
    path=os.getcwd()+'/'
    mlab.start()
    filename=config['f1arg1']
    start=int(config['f1arg2'])
    end=int(config['f1arg3'])
    res = mlab.run_func(path+config["f1"], {"arg1":filename,"arg2": start, "arg3":end})
    mlab.stop()
    print("done")
