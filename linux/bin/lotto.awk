#!/usr/bin/awk -f
BEGIN {
    usage = "lotto.awk CNT MIN MAX";
    srand();
    # numbers: needed, minium, maxium
    NUM=ARGV[1]+0; MIN=ARGV[2]+0; MAX=ARGV[3]+0;
    
    # check input
    if (!NUM||!MIN||!MAX||(MAX - MIN + 1 < NUM)) {printf("usage: %s\n", usage); exit;}

    Number=0; while (Number < NUM) {
        # get the number
        r=int(((rand() *(1+MAX-MIN))+MIN));
        # test former result
        if (array[r] == 0) { Number++; array[r]++;}}

    # print output, in order
    for (i=MIN;i<=MAX;i++) {if (array[i]) {printf("%d ",i);}}

    printf("\n"); exit;
}
