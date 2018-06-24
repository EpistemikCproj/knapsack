	.386p
	model flat
	ifndef	??version
	?debug	macro
	endm
	endif
	?debug	S "knapsack.c"
	?debug	T "knapsack.c"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
DGROUP	group	_BSS,_DATA
_DATA	segment dword public use32 'DATA'
$ejjccaia	label	byte
	db	0
	db	63	dup(?)
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_main	proc	near
?live1@0:
   ;	
   ;	int main( int argc, char *argv[] )
   ;	
	push      ebp
	mov       ebp,esp
	add       esp,-84
	push      ebx
	push      esi
	push      edi
	mov       esi,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  int i=0 ,	// loop index
   ;	
?live1@16: ; ESI = argc
@1:
	xor       ebx,ebx
   ;	
   ;			j ,	// check each input line
   ;			n ,	// total items
   ;			W ,	// maximum allowed weight of items (user-supplied)
   ;	
   ;			totweight=0 , // of items selected
   ;	
?live1@32: ; EBX = i, ESI = argc
	xor       eax,eax
	mov       dword ptr [ebp-12],eax
   ;	
   ;			maxProfit ;
   ;	
   ;	  char *bestitems = NULL ;
   ;	
	xor       edx,edx
	mov       dword ptr [ebp-16],edx
   ;	
   ;	  char temp[ KNAP_MAX_NAME_LEN ] = {0};
   ;	
	push      esi
	mov       esi,offset $ejjccaia
	lea       edi,dword ptr [ebp-84]
	mov       ecx,16
	rep   movsd
	pop       esi
   ;	
   ;	
   ;	  FILE *inputfile ;
   ;	  nodeArray pw ;
   ;	
   ;	  // check command line parameters
   ;	  if( argc < 2 )
   ;	
	cmp       esi,2
	jge       short @2
   ;	
   ;	  {
   ;		 printf( "\nUsage: %s 'file name' [max weight] \n\n", argv[0] );
   ;	
	mov       eax,dword ptr [ebp+12]
	push      dword ptr [eax]
	push      offset s@
	call      _printf
	add       esp,8
   ;	
   ;		 exit( 0 );
   ;	
	push      0
	call      _exit
	pop       ecx
   ;	
   ;	  }
   ;	
   ;	  if( argc < 3 )
   ;	
@2:
	cmp       esi,3
	jge       short @3
   ;	
   ;	  {
   ;		 printf( "\nPlease enter the maximum weight: " );
   ;	
?live1@144: ; EBX = i
	push      offset s@+39
	call      _printf
	pop       ecx
   ;	
   ;		 scanf( "%u", &W );
   ;	
	lea       edx,dword ptr [ebp-8]
	push      edx
	push      offset s@+74
	call      _scanf
	add       esp,8
   ;	
   ;	  }
   ;	
	jmp       short @4
   ;	
   ;	  else
   ;			W = atoi( argv[2] );
   ;	
@3:
	mov       ecx,dword ptr [ebp+12]
	push      dword ptr [ecx+8]
	call      _atol
	pop       ecx
	mov       dword ptr [ebp-8],eax
   ;	
   ;	
   ;	  printf( "\nfilename is %s \n", argv[1] );
   ;	
@4:
	mov       eax,dword ptr [ebp+12]
	push      dword ptr [eax+4]
	push      offset s@+77
	call      _printf
	add       esp,8
   ;	
   ;	  printf( "W == %u \n", W );
   ;	
	push      dword ptr [ebp-8]
	push      offset s@+95
	call      _printf
	add       esp,8
   ;	
   ;	#if KNAPSACK_MAIN_DEBUG > 0
   ;	  printf( "sizeof(node) == %u \n", sizeof(node) );
   ;	
	push      28
	push      offset s@+105
	call      _printf
	add       esp,8
   ;	
   ;	#endif
   ;	
   ;	  // open the file
   ;	  inputfile = fopen( argv[1], "r" );
   ;	
	push      offset s@+126
	mov       edx,dword ptr [ebp+12]
	push      dword ptr [edx+4]
	call      _fopen
	add       esp,8
	mov       esi,eax
   ;	
   ;	  if( !inputfile )
   ;	
?live1@272: ; EBX = i, ESI = inputfile
	test      esi,esi
	jne       short @5
   ;	
   ;	  {
   ;		 fprintf( stderr, "Error occurred opening file '%s' !\n", argv[1] );
   ;	
	mov       eax,dword ptr [ebp+12]
	push      dword ptr [eax+4]
	push      offset s@+128
	push      offset __streams+48
	call      _fprintf
	add       esp,12
   ;	
   ;		 exit( 1 );
   ;	
	push      1
	call      _exit
	pop       ecx
   ;	
   ;	  }
   ;	
   ;	  // first entry in the file should be the # of items
   ;	  if( fscanf(inputfile, "%u", &n) != 1 )
   ;	
@5:
	lea       edx,dword ptr [ebp-4]
	push      edx
	push      offset s@+164
	push      esi
	call      _fscanf
	add       esp,12
	dec       eax
	je        short @6
   ;	
   ;	  {
   ;		 fprintf( stderr, "Error getting # of items (%d) in file '%s' !\n", n, argv[1] );
   ;	
	mov       ecx,dword ptr [ebp+12]
	push      dword ptr [ecx+4]
	push      dword ptr [ebp-4]
	push      offset s@+167
	push      offset __streams+48
	call      _fprintf
	add       esp,16
   ;	
   ;		 exit( 2 );
   ;	
	push      2
	call      _exit
	pop       ecx
   ;	
   ;	  }
   ;	
   ;	  printf( "\nThere should be %d items in file '%s' \n", n, argv[1] );
   ;	
@6:
	mov       eax,dword ptr [ebp+12]
	push      dword ptr [eax+4]
	push      dword ptr [ebp-4]
	push      offset s@+213
	call      _printf
	add       esp,12
   ;	
   ;	
   ;	  // allocate the array
   ;	  if( !initNodeArray(&pw, n) )
   ;	
	push      dword ptr [ebp-4]
	lea       edx,dword ptr [ebp-20]
	push      edx
	call      _initNodeArray
	add       esp,8
	test      eax,eax
	jne       @9
   ;	
   ;		 exit( 3 );
   ;	
	push      3
	call      _exit
	pop       ecx
	jmp       @9
   ;	
   ;	
   ;	  // scan in the input lines
   ;	  while( !feof(inputfile) )
   ;	  {
   ;		 // get the data
   ;		 j = fscanf( inputfile, "%s %u %u", temp, &(pw[i].profit), &(pw[i].weight) );
   ;	
@8:
	imul      ecx,ebx,28
	add       ecx,dword ptr [ebp-20]
	add       ecx,12
	push      ecx
	imul      eax,ebx,28
	add       eax,dword ptr [ebp-20]
	add       eax,8
	push      eax
	lea       edx,dword ptr [ebp-84]
	push      edx
	push      offset s@+254
	push      esi
	call      _fscanf
	add       esp,20
   ;	
   ;	
   ;	#if KNAPSACK_MAIN_DEBUG > 1
   ;		 printf( "\n i == %d \n", i );
   ;		 printf( "temp == %s ; strlen(temp) == %d \n", temp, strlen(temp) );
   ;	#endif
   ;	
   ;		 if( j == 3 ) // got a complete line
   ;	
?live1@432: ; EBX = i, ESI = inputfile, EAX = j
	cmp       eax,3
	jne       @10
   ;	
   ;		 {
   ;			setName( &pw[i], temp );
   ;	
?live1@448: ; EBX = i, ESI = inputfile
	lea       ecx,dword ptr [ebp-84]
	push      ecx
	imul      eax,ebx,28
	add       eax,dword ptr [ebp-20]
	push      eax
	call      _setName
	add       esp,8
   ;	
   ;	
   ;			pw[i].level = pw[i].bound = 0 ;
   ;	
	fld       dword ptr [@11]
	mov       edx,ebx
	shl       edx,3
	sub       edx,ebx
	mov       ecx,dword ptr [ebp-20]
	fst       dword ptr [ecx+4*edx+20]
	call      __ftol
	mov       edx,ebx
	shl       edx,3
	sub       edx,ebx
	mov       ecx,dword ptr [ebp-20]
	mov       dword ptr [ecx+4*edx+4],eax
   ;	
   ;	
   ;			// calculate the p/w ratio
   ;			pw[i].pw
   ;	
	mov       eax,ebx
	shl       eax,3
	sub       eax,ebx
	mov       edx,dword ptr [ebp-20]
	cmp       dword ptr [edx+4*eax+12],0
	jle       short @12
	mov       ecx,ebx
	shl       ecx,3
	sub       ecx,ebx
	mov       eax,dword ptr [ebp-20]
	fild      dword ptr [eax+4*ecx+8]
	mov       edx,ebx
	shl       edx,3
	sub       edx,ebx
	mov       ecx,dword ptr [ebp-20]
	fild      dword ptr [ecx+4*edx+12]
	fdivp      st(1),st
	jmp       short @13
@12:
	fld       qword ptr [@11+4]
@13:
	mov       eax,ebx
	shl       eax,3
	sub       eax,ebx
	mov       edx,dword ptr [ebp-20]
	fstp      dword ptr [edx+4*eax+16]
   ;	
   ;			  = (pw[i].weight > 0) ? ((float)pw[i].profit / (float)pw[i].weight) : 0.0 ;
   ;	
   ;	#if KNAPSACK_MAIN_DEBUG > 1
   ;			displayNode( pw+i );
   ;	#endif
   ;	
   ;			getc( inputfile ) ; // eat the EOL
   ;	
	dec       dword ptr [esi+8]
	js        short @14
	inc       dword ptr [esi]
	jmp       short @15
@14:
	push      esi
	call      __fgetc
	pop       ecx
   ;	
   ;			i++ ; // index in the loop through the array
   ;	
@15:
	inc       ebx
@10:
@9:
	test      byte ptr [esi+18],32
	je        @8
   ;	
   ;	
   ;		 }// if( j == 3 )
   ;	
   ;	  }// while( !feof(inputfile) )
   ;	
   ;	#if KNAPSACK_MAIN_DEBUG > 0
   ;		 printf( "\nThere were %d items in file '%s' \n", i, argv[1] );
   ;	
	mov       ecx,dword ptr [ebp+12]
	push      dword ptr [ecx+4]
	push      ebx
	push      offset s@+263
	call      _printf
	add       esp,12
   ;	
   ;	#endif
   ;	
   ;	  fclose( inputfile );
   ;	
?live1@560: ; ESI = inputfile
	push      esi
	call      _fclose
	pop       ecx
   ;	
   ;	
   ;	#if KNAPSACK_MAIN_DEBUG > 1
   ;	  puts( "\nBEFORE SORTING:" );
   ;	  displayNodeArray( pw, n );
   ;	#endif
   ;	
   ;	  // sort the pw array
   ;	  qsort( pw, n, sizeof(node), compareNode );
   ;	
?live1@576: ; 
	push      offset _compareNode
	push      28
	push      dword ptr [ebp-4]
	push      dword ptr [ebp-20]
	call      _qsort
	add       esp,16
   ;	
   ;	
   ;	  puts( "\nAFTER SORTING:" );
   ;	
	push      offset s@+299
	call      _puts
	pop       ecx
   ;	
   ;	  displayNodeArray( pw, n );
   ;	
	push      dword ptr [ebp-4]
	push      dword ptr [ebp-20]
	call      _displayNodeArray
	add       esp,8
   ;	
   ;	
   ;	  // run the algorithm and display the results
   ;	  maxProfit = bestFirstSearch( pw, n, W, &totweight, &bestitems );
   ;	
	lea       eax,dword ptr [ebp-16]
	push      eax
	lea       edx,dword ptr [ebp-12]
	push      edx
	push      dword ptr [ebp-8]
	push      dword ptr [ebp-4]
	push      dword ptr [ebp-20]
	call      _bestFirstSearch
	add       esp,20
   ;	
   ;	  printf( "\nFor Weight limit %d: Max Profit == %d (actual weight == %d)\n",
   ;	
?live1@640: ; EAX = maxProfit
	push      dword ptr [ebp-12]
	push      eax
	push      dword ptr [ebp-8]
	push      offset s@+315
	call      _printf
	add       esp,16
   ;	
   ;			       W, maxProfit, totweight );
   ;	  printf( "Best items are: %s \n", bestitems ? bestitems : "NOT AVAILABLE !" );
   ;	
?live1@656: ; 
	cmp       dword ptr [ebp-16],0
	je        short @17
	mov       ecx,dword ptr [ebp-16]
	jmp       short @18
@17:
	mov       ecx,offset s@+398
@18:
	push      ecx
	push      offset s@+377
	call      _printf
	add       esp,8
   ;	
   ;	
   ;	  free( bestitems );
   ;	
	push      dword ptr [ebp-16]
	call      _free
	pop       ecx
   ;	
   ;	  deleteNodeArray( pw, n );
   ;	
	push      dword ptr [ebp-4]
	push      dword ptr [ebp-20]
	call      _deleteNodeArray
	add       esp,8
   ;	
   ;	
   ;	  printf( "\n PROGRAM ENDED.\n" );
   ;	
	push      offset s@+414
	call      _printf
	pop       ecx
   ;	
   ;	
   ;	  return 0 ;
   ;	
	xor       eax,eax
   ;	
   ;	
   ;	}// main()
   ;	
@20:
@19:
	pop       edi
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
	align 4        
@11:
	db        0,0,0,0,0,0,0,0,0,0,0,0
_main	endp
_bound	proc	near
?live1@752:
   ;	
   ;	void bound( node *x, const nodeArray pw, int n, int W )
   ;	
	push      ebp
	mov       ebp,esp
	add       esp,-8
	push      ebx
	push      esi
	push      edi
	mov       esi,dword ptr [ebp+20]
	mov       edx,dword ptr [ebp+12]
	mov       ebx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  int j ;
   ;	  int totweight ;
   ;	  float result = 0.0 ;
   ;	
?live1@768: ; EDX = pw, EBX = x, ESI = W
@21:
	xor       eax,eax
	mov       dword ptr [ebp-4],eax
   ;	
   ;	
   ;	#if KNAPSACK_BOUND_DEBUG > 1
   ;	  puts( "\nINSIDE bound():" );
   ;	  printf( " n == %d \n", n );
   ;	  displayNodeArray( pw, n );
   ;	#endif
   ;	
   ;	#if KNAPSACK_BOUND_DEBUG > 0
   ;	  printf( "\n bound(1): " );
   ;	  displayNode( x );
   ;	#endif
   ;	
   ;	  // calculate the new bound if the weight is under the limit
   ;	  if( x->weight < W )
   ;	
	cmp       esi,dword ptr [ebx+12]
	jle       short @22
   ;	
   ;	  {
   ;		 result = (float)x->profit ;
   ;	
	fild      dword ptr [ebx+8]
	fstp      dword ptr [ebp-4]
   ;	
   ;	
   ;		 j = x->level + 1 ;
   ;	
	mov       eax,dword ptr [ebx+4]
	inc       eax
   ;	
   ;	#if KNAPSACK_BOUND_DEBUG > 0
   ;		 printf( " bound(2): j == %d \n", j );
   ;	#endif
   ;	
   ;		 totweight = x->weight ;
   ;	
?live1@832: ; EAX = j, EDX = pw, EBX = x, ESI = W
	mov       ecx,dword ptr [ebx+12]
	jmp       short @24
   ;	
   ;	
   ;		 // grab as many items as possible
   ;		 while( j < n  &&  (totweight + pw[j].weight <= W) )
   ;		 {
   ;			totweight += pw[j].weight ;
   ;	
?live1@848: ; EAX = j, EDX = pw, ECX = totweight, EBX = x, ESI = W
@23:
	mov       edi,eax
	shl       edi,3
	sub       edi,eax
	add       ecx,dword ptr [edx+4*edi+12]
   ;	
   ;			result += (float)pw[j].profit ;
   ;	
	mov       edi,eax
	shl       edi,3
	sub       edi,eax
	fild      dword ptr [edx+4*edi+8]
	fadd      dword ptr [ebp-4]
	fstp      dword ptr [ebp-4]
   ;	
   ;			j++ ;
   ;	
	inc       eax
@24:
	cmp       eax,dword ptr [ebp+16]
	jge       short @25
	mov       edi,eax
	shl       edi,3
	sub       edi,eax
	mov       edi,dword ptr [edx+4*edi+12]
	add       edi,ecx
	cmp       esi,edi
	jge       short @23
   ;	
   ;	#if KNAPSACK_BOUND_DEBUG > 0
   ;			printf( " bound(3): result == %7.3f \n", result );
   ;			printf( " bound(4): j == %d \n", j );
   ;	#endif
   ;		 }
   ;	
   ;		 if( j < n )
   ;	
@25:
	cmp       eax,dword ptr [ebp+16]
	jge       short @26
   ;	
   ;			// grab fraction of jth item
   ;			result += ( ((float)(W - totweight)) * pw[j].pw );
   ;	
	sub       esi,ecx
	mov       dword ptr [ebp-8],esi
	fild      dword ptr [ebp-8]
	mov       ecx,eax
	shl       eax,3
	sub       eax,ecx
	fmul      dword ptr [edx+4*eax+16]
	fadd      dword ptr [ebp-4]
	fstp      dword ptr [ebp-4]
   ;	
   ;	
   ;	#if KNAPSACK_BOUND_DEBUG > 0
   ;		 printf( " bound(5): node %s has bound == %7.3f \n", x->name, result );
   ;	#endif
   ;	  }
   ;	
   ;	  x->bound = result ;
   ;	
?live1@944: ; EBX = x
@26:
@22:
	mov       edx,dword ptr [ebp-4]
	mov       dword ptr [ebx+20],edx
   ;	
   ;	
   ;	}//! bound()
   ;	
?live1@960: ; 
@27:
	pop       edi
	pop       esi
	pop       ebx
	pop       ecx
	pop       ecx
	pop       ebp
	ret 
_bound	endp
_TEXT	ends
_DATA	segment dword public use32 'DATA'
$mmjccaia	label	byte
	db	38
	db	0
$eakccaia	label	byte
	db	45
	db	0
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_bestFirstSearch	proc	near
?live1@976:
   ;	
   ;	int bestFirstSearch( const nodeArray pw, int n, int W, int *tw, char **best )
   ;	
	push      ebp
	mov       ebp,esp
	add       esp,-76
	push      ebx
	push      esi
	push      edi
	mov       edi,dword ptr [ebp+8]
	lea       esi,dword ptr [ebp-44]
   ;	
   ;	{
   ;	  int i = 0 ; // loop count
   ;	
?live1@992: ; ESI = &u, EDI = pw
@28:
	xor       eax,eax
	mov       dword ptr [ebp-4],eax
   ;	
   ;	
   ;	  node u, v ; // working nodes
   ;	
   ;	  const char include[] = "&" ;
   ;	
	mov       dx,word ptr [$mmjccaia]
	mov       word ptr [ebp-6],dx
   ;	
   ;	  const char exclude[] = "-" ;
   ;	
	mov       cx,word ptr [$eakccaia]
	mov       word ptr [ebp-8],cx
   ;	
   ;	
   ;	  PriorityQueue PQ ;
   ;	  int maxprofit = 0 ;
   ;	
	xor       ebx,ebx
   ;	
   ;	
   ;	  u.name = v.name = NULL ; // initialize the char*'s
   ;	
?live1@1056: ; EBX = maxprofit, ESI = &u, EDI = pw
	xor       eax,eax
	mov       dword ptr [ebp-72],eax
	mov       dword ptr [esi],eax
   ;	
   ;	
   ;	  initQueue( &PQ );
   ;	
	lea       edx,dword ptr [ebp-16]
	push      edx
	call      _initQueue
	pop       ecx
   ;	
   ;	
   ;	  // set the names of u and v to keep track of items properly
   ;	  setName( &u, exclude );
   ;	
	lea       ecx,dword ptr [ebp-8]
	push      ecx
	push      esi
	call      _setName
	add       esp,8
   ;	
   ;	  setName( &v, "root"  );
   ;	
	push      offset s@+432
	lea       eax,dword ptr [ebp-72]
	push      eax
	call      _setName
	add       esp,8
   ;	
   ;	
   ;	  v.level = -1 ; // start at -1 so the root node gets index == 0 in bound()
   ;	
	mov       dword ptr [ebp-68],-1
   ;	
   ;	  v.pw = u.pw = 0.0 ;
   ;	
	fld       dword ptr [@29]
	fst       dword ptr [esi+16]
	fstp      dword ptr [ebp-56]
   ;	
   ;	  v.profit = v.weight = 0 ;
   ;	
	xor       edx,edx
	mov       dword ptr [ebp-60],edx
	mov       dword ptr [ebp-64],edx
   ;	
   ;	
   ;	  // get the initial bound
   ;	  bound( &v, pw, n, W );
   ;	
	push      dword ptr [ebp+16]
	push      dword ptr [ebp+12]
	push      edi
	lea       eax,dword ptr [ebp-72]
	push      eax
	call      _bound
	add       esp,16
   ;	
   ;	
   ;	#if KNAPSACK_BFS_DEBUG > 0
   ;	  puts( "" );
   ;	
	push      offset s@+437
	call      _puts
	pop       ecx
   ;	
   ;	  displayNode( &v );
   ;	
	lea       ecx,dword ptr [ebp-72]
	push      ecx
	call      _displayNode
	pop       ecx
   ;	
   ;	#endif
   ;	
   ;	  insertNode( &PQ, &v ); // start the state space tree with the root node
   ;	
	lea       eax,dword ptr [ebp-72]
	push      eax
	lea       edx,dword ptr [ebp-16]
	push      edx
	call      _insertNode
	add       esp,8
   ;	
   ;	
   ;	#if KNAPSACK_BFS_DEBUG > 0
   ;	  displayQueue( &PQ );
   ;	
	lea       ecx,dword ptr [ebp-16]
	push      ecx
	call      _displayQueue
	pop       ecx
   ;	
   ;	  printf( "START WHILE LOOP... \n\n" );
   ;	
	push      offset s@+438
	call      _printf
	pop       ecx
	jmp       @31
   ;	
   ;	#endif
   ;	
   ;	  while( !isEmptyQueue(&PQ) )// &&  i < limit ) // limit prevents a runaway loop
   ;	  {
   ;	#if KNAPSACK_BFS_DEBUG > 1
   ;		 printf( "\nPQ.nodes == %p \n", PQ.nodes );
   ;		 printf( "PQ.size == %d \n", PQ.size );
   ;	#endif
   ;	#if KNAPSACK_BFS_DEBUG > 2
   ;		 displayQueue( &PQ );
   ;	#endif
   ;	
   ;		 removeNode( &PQ, &v ); // remove node with best bound
   ;	
@30:
	lea       eax,dword ptr [ebp-72]
	push      eax
	lea       edx,dword ptr [ebp-16]
	push      edx
	call      _removeNode
	add       esp,8
   ;	
   ;	#if KNAPSACK_BFS_DEBUG > 0
   ;		 printf( "\nBFS( v ): " );
   ;	
	push      offset s@+461
	call      _printf
	pop       ecx
   ;	
   ;		 displayNode( &v );
   ;	
	lea       ecx,dword ptr [ebp-72]
	push      ecx
	call      _displayNode
	pop       ecx
   ;	
   ;	#endif
   ;	
   ;		 if( v.bound > maxprofit ) // check if node is still promising
   ;	
	mov       dword ptr [ebp-76],ebx
	fild      dword ptr [ebp-76]
	fcomp     dword ptr [ebp-52]
	fnstsw ax
	sahf
	jae       @33
   ;	
   ;		 {
   ;	#if KNAPSACK_BFS_DEBUG > 0
   ;			printf( "v.bound == %7.3f \n", v.bound );
   ;	
	fld       dword ptr [ebp-52]
	add       esp,-8
	fstp      qword ptr [esp]
	push      offset s@+473
	call      _printf
	add       esp,12
   ;	
   ;	#endif
   ;	
   ;			// SET u TO THE CHILD THAT INCLUDES THE NEXT ITEM
   ;			u.level = v.level + 1 ;
   ;	
	mov       edx,dword ptr [ebp-68]
	inc       edx
	mov       dword ptr [esi+4],edx
   ;	
   ;	
   ;			// keep track of all items in this node
   ;			setName( &u, v.name );
   ;	
	push      dword ptr [ebp-72]
	push      esi
	call      _setName
	add       esp,8
   ;	
   ;			appendName( &u, include );
   ;	
	lea       ecx,dword ptr [ebp-6]
	push      ecx
	push      esi
	call      _appendName
	add       esp,8
   ;	
   ;			appendName( &u, pw[u.level].name );
   ;	
	mov       eax,dword ptr [esi+4]
	mov       edx,eax
	shl       eax,3
	sub       eax,edx
	push      dword ptr [edi+4*eax]
	push      esi
	call      _appendName
	add       esp,8
   ;	
   ;	
   ;			u.weight = v.weight + pw[u.level].weight ;
   ;	
	mov       ecx,dword ptr [esi+4]
	mov       eax,ecx
	shl       ecx,3
	sub       ecx,eax
	mov       edx,dword ptr [edi+4*ecx+12]
	add       edx,dword ptr [ebp-60]
	mov       dword ptr [esi+12],edx
   ;	
   ;			u.profit = v.profit + pw[u.level].profit ;
   ;	
	mov       ecx,dword ptr [esi+4]
	mov       eax,ecx
	shl       ecx,3
	sub       ecx,eax
	mov       edx,dword ptr [edi+4*ecx+8]
	add       edx,dword ptr [ebp-64]
	mov       dword ptr [esi+8],edx
   ;	
   ;	
   ;	#if KNAPSACK_BFS_DEBUG > 0
   ;			printf( "\nBFS( u ): " );
   ;	
	push      offset s@+492
	call      _printf
	pop       ecx
   ;	
   ;			displayNode( &u );
   ;	
	push      esi
	call      _displayNode
	pop       ecx
   ;	
   ;	#endif
   ;	
   ;			if( u.weight <=  W  &&  u.profit > maxprofit )
   ;	
	mov       ecx,dword ptr [esi+12]
	cmp       ecx,dword ptr [ebp+16]
	jg        @36
	cmp       ebx,dword ptr [esi+8]
	jge       @36
   ;	
   ;			{
   ;			  maxprofit = u.profit ;
   ;	
?live1@1488: ; ESI = &u, EDI = pw
	mov       ebx,dword ptr [esi+8]
   ;	
   ;			  *tw = u.weight ;
   ;	
?live1@1504: ; EBX = maxprofit, ESI = &u, EDI = pw
	mov       eax,dword ptr [ebp+20]
	mov       edx,dword ptr [esi+12]
	mov       dword ptr [eax],edx
   ;	
   ;			  printf( "\nBFS(%d): maxprofit now == %d \n", i, maxprofit );
   ;	
	push      ebx
	push      dword ptr [ebp-4]
	push      offset s@+504
	call      _printf
	add       esp,12
   ;	
   ;			  printf( "\t current best items are %s \n", u.name );
   ;	
	push      dword ptr [esi]
	push      offset s@+536
	call      _printf
	add       esp,8
   ;	
   ;			  printf( "\t current weight of items is %d \n", *tw );
   ;	
	mov       ecx,dword ptr [ebp+20]
	push      dword ptr [ecx]
	push      offset s@+566
	call      _printf
	add       esp,8
   ;	
   ;	
   ;			  // keep track of overall list of best items
   ;			  *best = (char*)realloc( *best, (strlen(u.name)+1) * sizeof(char) );
   ;	
	push      dword ptr [esi]
	call      _strlen
	pop       ecx
	inc       eax
	push      eax
	mov       eax,dword ptr [ebp+24]
	push      dword ptr [eax]
	call      _realloc
	add       esp,8
	mov       edx,dword ptr [ebp+24]
	mov       dword ptr [edx],eax
   ;	
   ;			  if( *best )
   ;	
	mov       ecx,dword ptr [ebp+24]
	cmp       dword ptr [ecx],0
	je        short @37
   ;	
   ;				 strcpy( *best, u.name );
   ;	
	push      dword ptr [esi]
	mov       eax,dword ptr [ebp+24]
	push      dword ptr [eax]
	call      _strcpy
	add       esp,8
	jmp       short @38
   ;	
   ;			  else
   ;					fprintf( stderr, "Memory allocation error for *best !\n" );
   ;	
@37:
	push      offset s@+600
	push      offset __streams+48
	call      _fprintf
	add       esp,8
   ;	
   ;			}
   ;	
   ;			bound( &u, pw, n, W );
   ;	
@38:
@36:
	push      dword ptr [ebp+16]
	push      dword ptr [ebp+12]
	push      edi
	push      esi
	call      _bound
	add       esp,16
   ;	
   ;			if( u.bound > maxprofit )
   ;	
	mov       dword ptr [ebp-76],ebx
	fild      dword ptr [ebp-76]
	fcomp     dword ptr [esi+20]
	fnstsw ax
	sahf
	jae       short @39
   ;	
   ;			  insertNode( &PQ, &u );
   ;	
	push      esi
	lea       edx,dword ptr [ebp-16]
	push      edx
	call      _insertNode
	add       esp,8
   ;	
   ;	
   ;	
   ;			// SET u TO THE CHILD THAT DOES NOT INCLUDE THE NEXT ITEM
   ;	
   ;			// keep track of all items in this node
   ;			setName( &u, v.name );
   ;	
@39:
	push      dword ptr [ebp-72]
	push      esi
	call      _setName
	add       esp,8
   ;	
   ;			appendName( &u, exclude ); // alter the name here just to monitor backtracking
   ;	
	lea       ecx,dword ptr [ebp-8]
	push      ecx
	push      esi
	call      _appendName
	add       esp,8
   ;	
   ;	
   ;			// we already incremented the level in the previous section
   ;			u.weight = v.weight ;
   ;	
	mov       eax,dword ptr [ebp-60]
	mov       dword ptr [esi+12],eax
   ;	
   ;			u.profit = v.profit ;
   ;	
	mov       edx,dword ptr [ebp-64]
	mov       dword ptr [esi+8],edx
   ;	
   ;	
   ;			bound( &u, pw, n, W );
   ;	
	push      dword ptr [ebp+16]
	push      dword ptr [ebp+12]
	push      edi
	push      esi
	call      _bound
	add       esp,16
   ;	
   ;			if( u.bound > maxprofit ) // if this node is still promising
   ;	
	mov       dword ptr [ebp-76],ebx
	fild      dword ptr [ebp-76]
	fcomp     dword ptr [esi+20]
	fnstsw ax
	sahf
	jae       short @40
   ;	
   ;			  insertNode( &PQ, &u );
   ;	
	push      esi
	lea       edx,dword ptr [ebp-16]
	push      edx
	call      _insertNode
	add       esp,8
   ;	
   ;		 }
   ;	
   ;		 i++ ;
   ;	
@40:
@33:
	inc       dword ptr [ebp-4]
   ;	
   ;	#if KNAPSACK_BFS_DEBUG > 0
   ;		 printf( "\n i == %d \n\n", i );
   ;	
	push      dword ptr [ebp-4]
	push      offset s@+637
	call      _printf
	add       esp,8
@31:
	lea       ecx,dword ptr [ebp-16]
	push      ecx
	call      _isEmptyQueue
	pop       ecx
	test      eax,eax
	je        @30
   ;	
   ;	#endif
   ;	
   ;	  }// while( !isEmptyQueue(&PQ)  &&  i < capacity )
   ;	
   ;	#if KNAPSACK_BFS_DEBUG == 0
   ;	  printf( "\n Final i == %d \n", i );
   ;	#endif
   ;	
   ;	  free( u.name );
   ;	
?live1@1840: ; EBX = maxprofit, ESI = &u
	push      dword ptr [esi]
	call      _free
	pop       ecx
   ;	
   ;	  free( v.name );
   ;	
?live1@1856: ; EBX = maxprofit
	push      dword ptr [ebp-72]
	call      _free
	pop       ecx
   ;	
   ;	  deleteQueue( &PQ );
   ;	
	lea       eax,dword ptr [ebp-16]
	push      eax
	call      _deleteQueue
	pop       ecx
   ;	
   ;	
   ;	  return maxprofit ;
   ;	
	mov       eax,ebx
   ;	
   ;	
   ;	}// bestFirstSearch()
   ;	
?live1@1904: ; 
@42:
@41:
	pop       edi
	pop       esi
	pop       ebx
	mov       esp,ebp
	pop       ebp
	ret 
	align 4        
@29:
	db        0,0,0,0
_bestFirstSearch	endp
_TEXT	ends
_DATA	segment dword public use32 'DATA'
s@	label	byte
	db	10
	;	s@+1:
	db	"Usage: %s 'file name' [max weight] ",10,10,0,10
	;	s@+40:
	db	"Please enter the maximum weight: ",0
	;	s@+74:
	db	"%u",0,10
	;	s@+78:
	db	"filename is %s ",10,0
	;	s@+95:
	db	"W == %u ",10,0
	;	s@+105:
	db	"sizeof(node) == %u ",10,0
	;	s@+126:
	db	"r",0
	;	s@+128:
	db	"Error occurred opening file '%s' !",10,0
	;	s@+164:
	db	"%u",0
	;	s@+167:
	db	"Error getting # of items (%d) in file '%s' !",10,0,10
	;	s@+214:
	db	"There should be %d items in file '%s' ",10,0
	;	s@+254:
	db	"%s %u %u",0,10
	;	s@+264:
	db	"There were %d items in file '%s' ",10,0,10
	;	s@+300:
	db	"AFTER SORTING:",0,10
	;	s@+316:
	db	"For Weight limit %d: Max Profit == %d (actual weight == %d)"
	db	10,0
	;	s@+377:
	db	"Best items are: %s ",10,0
	;	s@+398:
	db	"NOT AVAILABLE !",0,10
	;	s@+415:
	db	" PROGRAM ENDED.",10,0
	;	s@+432:
	db	"root",0,0
	;	s@+438:
	db	"START WHILE LOOP... ",10,10,0,10
	;	s@+462:
	db	"BFS( v ): ",0
	;	s@+473:
	db	"v.bound == %7.3f ",10,0,10
	;	s@+493:
	db	"BFS( u ): ",0,10
	;	s@+505:
	db	"BFS(%d): maxprofit now == %d ",10,0,9
	;	s@+537:
	db	" current best items are %s ",10,0,9
	;	s@+567:
	db	" current weight of items is %d ",10,0
	;	s@+600:
	db	"Memory allocation error for *best !",10,0,10
	;	s@+638:
	db	" i == %d ",10,10,0
	align	4
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
	extrn	__streams:byte
	public	_main
	extrn	__setargv__:near
	extrn	_printf:near
	extrn	_exit:near
	extrn	_scanf:near
	extrn	_atol:near
	extrn	_fopen:near
	extrn	_fprintf:near
	extrn	_fscanf:near
	extrn	_initNodeArray:near
	extrn	_setName:near
	extrn	__fgetc:near
	extrn	_fclose:near
	extrn	_qsort:near
	extrn	_compareNode:near
	extrn	_puts:near
	extrn	_displayNodeArray:near
	public	_bestFirstSearch
	extrn	_free:near
	extrn	_deleteNodeArray:near
	extrn	__ftol:near
	public	_bound
	extrn	_initQueue:near
	extrn	_displayNode:near
	extrn	_insertNode:near
	extrn	_displayQueue:near
	extrn	_isEmptyQueue:near
	extrn	_removeNode:near
	extrn	_appendName:near
	extrn	_realloc:near
	extrn	_strlen:near
	extrn	_strcpy:near
	extrn	_deleteQueue:near
	extrn	__turboFloat:word
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\math.h" 8825 10304
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\stddef.h" 8825 10304
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\string.h" 8825 10304
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\stdlib.h" 8825 10304
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\_null.h" 8825 10304
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\_nfile.h" 8825 10304
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\_defs.h" 8825 10304
	?debug	D "D:\PROGRA~1\BC5\INCLUDE\stdio.h" 8825 10304
	?debug	D "node.h" 11898 45602
	?debug	D "knapsack.c" 11909 36943
	end
