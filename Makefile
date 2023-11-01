.NOTPARALLEL:

MIN_WORKERS=2000
MAX_WORKERS=6000
STEP_WORKERS=2000
NUM_TRIALS=3

VERSIONS=stable unstable_old unstable

default:
	@echo "make build  : will build the Docker containers and the simulators (do this first)"
	@echo "make check  : will run one experiment with all containers to check that makespans are the same"
	@echo "make run    : will run the experiment with whatever has been built last"

build:
	@for version in ${VERSIONS} ; do \
    		echo "** Building for SimGrid $${version} **" ; \
		mkdir build_simgrid_$${version} ; \
		chmod -R 777 build_simgrid_$${version} ; \
		docker run -it --rm -v `pwd`:/home/simgrid -w /home/simgrid/build_simgrid_$${version}/ simgrid/$${version} bash -c "apt update && apt install -y cmake gcc g++ libboost-dev && cmake .. && make master_worker_$${version} VERBOSE=1" ; \
	done	
check:
	python3 ./check_makespans.py ${VERSIONS}

run: 
	python3 ./run_experiments.py ${MIN_WORKERS} ${MAX_WORKERS} ${STEP_WORKERS} ${NUM_TRIALS} ${VERSIONS}

clean:
	/bin/rm -rf build_*

