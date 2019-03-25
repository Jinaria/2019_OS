// This file is first HW of the OS class.
// @author : Seung-gi Jin
// @last change : 2019 03 25 16:17


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <sys/wait.h>

const int MAX_COMMAND_LENGTH = 256; // max length of input command



// A function that removes spaces at both ends of a string.
char *trim(char *s){
	if(s == NULL)
		return NULL;
	char *begin;
	begin = s;

	// remove left space
	while(isspace(*begin)){
		begin++;
	}
	s = begin;
	
	// remove right space
	begin = s + strlen(s) - 1;
	while(isspace(*begin)){
		begin--;
	}
	*(begin + 1) = '\0';
	

	return s;
}


int main (int argc, char ** argv) {
	

	// batch file case
 	if (argc > 1) {
		FILE *file_pointer = fopen(argv[1], "r");
		char command[MAX_COMMAND_LENGTH];
		
		// Repeat until the end of the file is reached
		while (!feof(file_pointer)) {
			fgets(command, MAX_COMMAND_LENGTH, file_pointer);
			// remove enter
			*(command + strlen(command) - 1) = '\0';
			printf("%s\n", command);
			
			// if input is quit, stop shell
			if(strcmp(command, "quit") == 0) break;
			
			// token one line and trim
			char *temp = strtok(command, ";");
			char *ptr = trim(temp);
			
			while(temp != NULL){
				int pid = fork();
				
				if(pid < 0){
					printf("failed to create child process\n");
					exit(-1);
				}
				else if(pid == 0){
					int i = 0;
					char *_argv[5];
					_argv[i] = strtok(ptr, " ");
					while(_argv[i] != NULL){
						_argv[++i] = strtok(NULL, " ");
					}
					execvp(ptr, _argv);
					exit(0);
				}
				else{
					// Wait until every child process is finished
					wait(0);

					temp = strtok(NULL, ";");
					ptr = trim(temp);
				}
			}
			
		}
	} else {
		char command[MAX_COMMAND_LENGTH];
		
		printf("prompt>");
		// Repeat until quit is entered
		while(fgets(command, MAX_COMMAND_LENGTH, stdin) != NULL){

			*(command + strlen(command) - 1) = '\0';

			if(strcmp(command, "quit") == 0) break;

			char *temp = strtok(command, ";");
			char *ptr = trim(temp);

			while(temp != NULL){
				
				int pid = fork();
				
				if(pid < 0){
					printf("failed to create child process\n");
					exit(-1);
				}
				else if(pid == 0){
					int i = 0;
					char *_argv[5];
					_argv[i] = strtok(ptr, " ");
					while(_argv[i] != NULL){
						_argv[++i] = strtok(NULL, " ");
					}
					execvp(ptr, _argv);
					exit(0);
				}
				else{
					// Wait until every child process is finished
					wait(0);

					temp = strtok(NULL, ";");
					ptr = trim(temp);
				}
			}
			printf("prompt>");
		}
	}
}