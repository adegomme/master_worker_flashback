.NOTPARALLEL:

MIN_WORKERS=1000
MAX_WORKERS=7000
STEP_WORKERS=1000
NUM_TRIALS=1

VERSIONS=v3_10 v3_12 v3_20 v3_24 v3_34
#VERSIONS=v3_20

default:
	@echo "make build  : will build the Docker containers and the simulators (do this first)"
	@echo "make run    : will run the experiment with whatever has been built last"

build: clean
	@for version in ${VERSIONS} ; do \
    		echo "** Building for SimGrid $${version} **" ; \
		echo docker build -t simgrid_$${version} -f Dockerfile_simgrid_$${version} . ; \
		docker build -t simgrid_$${version} -f Dockerfile_simgrid_$${version} . ; \
		mkdir build_simgrid_$${version} ; \
		docker run -it --rm -v `pwd`:/home/simgrid -w /home/simgrid/build_simgrid_$${version}/ simgrid_$${version} cmake .. ; \
		docker run -it --rm -v `pwd`:/home/simgrid -w /home/simgrid/build_simgrid_$${version}/ simgrid_$${version} make master_worker_$${version} ; \
	done	

run: 
	python3 ./run_experiments.py ${MIN_WORKERS} ${MAX_WORKERS} ${STEP_WORKERS} ${NUM_TRIALS} ${VERSIONS}

clean:
	/bin/rm -rf build_*

