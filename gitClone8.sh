#!/bin/bash
##################################################################
#    functions
##################################################################

installPyRepo() {
	git clone https://github.com/SpiNNakerManchester/$1
	cd $1
	if [ -f setup.py ] ; then
		python3 setup.py develop --no-deps || exit $?
	fi
	cd ..
}

installMyRepo() {
        git clone https://github.com/such-a-git/$1
        cd $1
        if [ -f setup.py ] ; then
                python3 setup.py develop --no-deps || exit $?
        fi
        cd ..
}

installCRepo() {
	git clone https://github.com/SpiNNakerManchester/$1
}

buildCCode() {
export NEURAL_MODELLING_DIRS=`pwd`/sPyNNaker/neural_modelling 
export SPINN_DIRS=`pwd`/spinnaker_tools 
export PATH=$PATH:`pwd`/spinnaker_tools/tools 

cd spinnaker_tools
source $PWD/setup
make clean
make || exit $?
cd ..
cd spinn_common
make clean
make || exit $?
make install
cd ..
cd SpiNNFrontEndCommon/c_common/
cd front_end_common_lib/
make install-clean
cd ..
make clean
make || exit $?
make install
cd ../..
cd sPyNNaker/neural_modelling/
make clean
make || exit $?
cd ../..
echo "completed"
cd ..

}


##################################################################
#    Script
##################################################################

# create a virtual environment
virtualenv $1
cd $1


source bin/activate

installCRepo  spinnaker_tools
installCRepo  spinn_common	
installPyRepo SpiNNUtils	
installPyRepo SpiNNMachine	
installPyRepo SpiNNStorageHandlers	
installPyRepo PACMAN	
installPyRepo SpiNNMan	
installPyRepo DataSpecification	
installPyRepo SpiNNFrontEndCommon	
installPyRepo SpiNNakerGraphFrontEnd
installPyRepo spalloc
installPyRepo sPyNNaker	
installPyRepo sPyNNaker8	
installPyRepo PyNN8Examples
# installMyRepo motif 
# installMyRepo neat-spinnaker
# installMyRepo NE16


# install python dependencies
pip3 install numpy 
pip3 install six 
pip3 install enum34 
pip3 install scipy 
pip3 install lxml 
pip3 install matplotlib 
pip3 install "pyNN>=0.9" 
pip3 install requests 
pip3 install appdirs
pip3 install spalloc 
pip3 install rig
pip3 install testfixtures
pip3 install pytest
pip3 install jsonschema
pip3 install lazyarray
pip3 install "neo==0.6.1"
pip3 install futures
pip3 install pylru
pip3 install sortedcollections
pip3 install csa
pip3 install pathos
pip3 install graphviz
pip3 install Pillow


echo export NEURAL_MODELLING_DIRS=`pwd`/sPyNNaker/neural_modelling >> bin/activate
echo export SPINN_DIRS=`pwd`/spinnaker_tools >> bin/activate
echo export PATH=$PATH:`pwd`/spinnaker_tools/tools >> bin/activate


# build the c code
buildCCode


# cd PyNN8Examples/examples
# python -u va_benchmark.py



