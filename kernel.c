void kernel_main(void){
    char* video_memory = (char*)0xB8000;
    const char* message = "hello world";
    int i;

    // clear screen with spaces
    for (i = 0; i < 80 * 25; i++) {
        video_memory[i*2] = ' ';     // character
        video_memory[i*2 + 1] = 0x07; // attribute byte
    }

    // print message at top-left
    for (i = 0; message[i] != '\0'; i++) {
        video_memory[i*2] = message[i];
        video_memory[i*2 + 1] = 0x07;
    }

    while(1){} // halt
}
