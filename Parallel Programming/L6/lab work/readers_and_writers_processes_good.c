#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>


struct User {
    int id;
    int role_id;
};

void down_sem(int sid, int count) {
    struct sembuf sem_struct;
    
    sem_struct.sem_num = 0; 
    sem_struct.sem_op = -count;
    sem_struct.sem_flg = 0;

    semop(sid, &sem_struct, 1);
}

void up_sem(int sid, int count) {
    struct sembuf sem_struct;
    
    sem_struct.sem_num = 0; 
    sem_struct.sem_op = count;
    sem_struct.sem_flg = 0;

    semop(sid, &sem_struct, 1);
}

int main() {
	pid_t pid;
    struct timeval  tv1, tv2;
    struct User *shared;
    

    int READERS_COUNT = 10;
    int WRITERS_COUNT = 5;
    int ATTEMPTS = 10000;

    // Allocate memory
    int sm = shmget( IPC_PRIVATE, sizeof(struct User), 0666 | IPC_CREAT | IPC_EXCL );
    // Attach to the process
    shared = (struct User*)shmat(sm, NULL, 0);

    // Create semaphore
    int sem_id = semget(IPC_PRIVATE, 1, 0666 | IPC_CREAT);
    up_sem(sem_id, READERS_COUNT);

    gettimeofday(&tv1, NULL); // Wall clock time

    for(int i=0; i<READERS_COUNT; i++) {
        pid = fork();
        if (pid == 0) {
            int local_id;
            int local_role;

            // READER
            for(int j=0; j<ATTEMPTS; j++) {  
                down_sem(sem_id, 1);
                local_id = shared->id; 
                local_role = shared->role_id;
                up_sem(sem_id, 1);

                if (local_id != local_role) {
                    printf("Read current user: %d, %d\n", local_id, local_role);             
                }                
            }

            return 0;
        }
    }

    for(int i=0; i<WRITERS_COUNT; i++) {
        pid = fork();
        if (pid == 0) {
            int id = 0;
            // WRITER
            for(int j=0; j<ATTEMPTS; j++) {
                id = rand() % 10;

                down_sem(sem_id, READERS_COUNT);

                shared->id = id;
                shared->role_id = id;

                up_sem(sem_id, READERS_COUNT);
            }

            return 0;
        }
    }

    // We in parent process only
    while(wait(NULL) != -1) {};

    // Remove memory
    shmctl(sm, IPC_RMID, NULL);

    gettimeofday(&tv2, NULL);

    printf ("Total time = %f seconds\n",
         (double) (tv2.tv_usec - tv1.tv_usec) / 1000000 +
         (double) (tv2.tv_sec - tv1.tv_sec));
}