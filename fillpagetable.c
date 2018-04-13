

#include <stdlib.h>
#include <stdio.h>


int main(int argc, char* argv[]){
	if(argc != 2){
		printf("Expected 1 file name\n");
		exit(-1);
	}

	printf("Writing page table...\n");
	
	FILE * PT;
	char* PT_file_name = argv[1];
	if( (PT = fopen(PT_file_name, "w")) == NULL){
		printf("Error: Can't open file %s\n", PT_file_name);
		exit(-1);
	}
	
	fprintf(PT, ".orig x1000 ; start of page table\n");

	int i = 0; // PTE counter
	for(; i < 24; i++){
		// System PTEs
		fprintf(PT, ".fill 0x%02X04 ; PTE %i\n", (i << 1), i);
	}
	
    // User PTEs
	for(; i < 128; i++){
        int frame_number = 0;
        int privledge_bits = 0;
		switch(i){
			case 24:
                frame_number = 25;
                privledge_bits = 0xC;
				break;
			case 96 : 
                frame_number = 28;
                privledge_bits = 0xC;
                
				break;
			case 126 : 
                frame_number = 29;
                privledge_bits = 0xC;
				break;
            default:
                frame_number = 0;
                privledge_bits = 0x0;
                break;
        }
			fprintf(PT, ".fill 0x%02X0%01X ; PTE %i\n", frame_number << 1, privledge_bits, i);
	}
	


	fprintf(PT, ".end");
	printf("done\n");
	fclose(PT);
	exit(0);
}

