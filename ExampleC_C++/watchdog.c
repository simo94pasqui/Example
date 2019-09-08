#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <time.h>
#include <pthread.h>
#include <sys/time.h>
#include <getopt.h>
#include <errno.h>
#include <dirent.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

static void AddLog(char* folder ,const char* string)
{
    FILE* f;
    struct timeval new_time;
    char str_log[100];
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);
    
    sprintf(str_log,"%s/watchdog.log",folder);
    f = fopen(str_log,"ab");

    bzero(str_log, 100);
    sprintf(str_log,"[%d-%d-%d %d:%d:%d]: %s\n", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec, string);

    fwrite(str_log,1,strlen(str_log),f);
    fflush(f);

    fclose(f);
}

int get_pid(char* program)
{
    char line[6];
    char command[100];
    FILE *cmd;
    pid_t pid;
    
    pid = 0;
    sprintf(line, "");

    sprintf(command,"pidof %s",program);
    cmd = popen(command, "r");
    fgets(line, 6, cmd);
    pid = strtoul(line, NULL, 10);

    printf("pid = %u", pid);
    pclose(cmd);

    return pid;
}

int main (int argc, char *argv[])
{
    // parametri:
    // 1) nome processo da monitorare
    // 2) timeout di controllo stato in secondi
    // 3) path in cui salvare i file di log
    // 4) percorso completo del processo da rilanciare in caso non venga trovato in esecuzione il processo

    struct timeval start, stop;
    int rc;
    int pid;
    int max_delta = atoi(argv[2]);
    char command[100];
    int ret_value;
    int pipe_cmd, numread;
    char buf[10];
    DIR *dp;
    struct dirent *ep;
    char microsd_empy;

    rc = gettimeofday(&start, NULL);

    int cond=1;

    while(cond)
    {

        rc = gettimeofday(&stop, NULL);
        int delta = stop.tv_sec - start.tv_sec;

        if(delta > max_delta)
        {
            pid=get_pid(argv[1]);
            if(pid == 0)
            {
                printf("\nprocess [%s] ...restart", argv[1]);
                AddLog(argv[3],"Application_not_running");
                sleep(1);
                char cmd[128];
                sprintf(cmd,"%s &", argv[4]);
                system(cmd);
            }
            else
            {
                printf("\nprocess [%i][%s] works correctly",pid, argv[1]);
            }

            start = stop;
        }
        else sleep(5);
    }

    return 1;
}

