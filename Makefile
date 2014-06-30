
CC := gcc
MY_CFLAGS := -Wall -g
MY_DEPS := -lpthread -lrt -g

%.o: %.c
	$(CC) $(MY_CFLAGS) -c $< -o $@

my-progs := rt_task.bin ts_task.bin recv_nl_uevent.bin rt_hydra.bin fs_slammer.bin
my-progs += sched_test.bin malloc_test.bin cpu_hogd.bin frw.bin pipe_reader.bin pipe_writer.bin
my-progs += timerfd_test.bin test_pipe.bin test_spin.bin test_mmap.bin test_mmap2.bin
my-progs += test_waitpid.bin test_termios.bin test_free.bin test_env.bin test_file_del.bin
my-progs += test_nanosleep.bin test_pid_inode_leak.bin pci_config_rw.bin
my-progs += test_mmap3.bin test_xlock.bin test_sigabrt.bin test_clone.bin
my-progs += test_fork.bin test_fork_pthread.bin test_syswait.bin
my-progs += test_tasklock.bin test_pthread_waitpid.bin test_iorw.bin test_sigusr1.bin


.PHONY : all
all : $(my-progs)

%.bin: %.o
	$(CC) $(MY_DEPS) $< -o $@

test_xlock.bin: xlock.o 
test_xlock.bin: MY_DEPS += xlock.o

fs_slammer.bin: MY_DEPYS += -lpthread
pipe_writer.bin: utils.o
pipe_writer.bin: MY_DEPS += utils.o

test_sigabrt.bin: MY_DEPS += -pie
test_sigabrt.o: MY_CFLAGS += -fPIE

test_fork_pthread.bin: MY_DEPS += -lpthread
test_syswait.bin: MY_DEPS += -lpthread

test_tasklock.bin: MY_DEPS += -lpthread
test_pthread_waitpid.bin: MY_DEPS += -lpthread
	


.PHONY : clean
clean:
	rm -rf *.o
	rm -rf $(my-progs)