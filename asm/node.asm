	.386p
	model flat
	ifndef	??version
	?debug	macro
	endm
	endif
	?debug	S "node.c"
	?debug	T "node.c"
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
_DATA	segment dword public use32 'DATA'
_DATA	ends
_BSS	segment dword public use32 'BSS'
_BSS	ends
DGROUP	group	_BSS,_DATA
_DATA	segment dword public use32 'DATA'
	align	4
_MemCount	label	dword
	dd	0
	align	4
_MaxMemCount	label	dword
	dd	0
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_GetNode	proc	near
?live1@0:
   ;	
   ;	BOOLEAN GetNode( nodePtr *g )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	mov       ebx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	#if KNAPSACK_NODE_DEBUG > 0
   ;	  printf( "\nGetNode(): MemCount == %d ", MemCount );
   ;	
?live1@16: ; EBX = g
@1:
	push      dword ptr [_MemCount]
	push      offset s@
	call      _printf
	add       esp,8
   ;	
   ;	#endif
   ;	
   ;	  *g = (nodePtr)malloc( sizeof(node) );
   ;	
	push      28
	call      _malloc
	pop       ecx
	mov       dword ptr [ebx],eax
   ;	
   ;	  if( !(*g) )
   ;	
	cmp       dword ptr [ebx],0
	jne       short @2
   ;	
   ;	  {
   ;		 fprintf( stderr, "GetNode(): malloc error !\n" );
   ;	
?live1@64: ; 
	push      offset s@+28
	push      offset __streams+48
	call      _fprintf
	add       esp,8
   ;	
   ;		 return False ;
   ;	
	xor       eax,eax
@6:
	pop       ebx
	pop       ebp
	ret 
   ;	
   ;	  }
   ;	
   ;	  (*g)->name = NULL ; // have to initialize the char* of new nodes
   ;	
?live1@96: ; EBX = g
@2:
	mov       edx,dword ptr [ebx]
	xor       ecx,ecx
	mov       dword ptr [edx],ecx
   ;	
   ;	
   ;	  MemCount++ ;
   ;	
?live1@112: ; 
	inc       dword ptr [_MemCount]
   ;	
   ;	  if( MemCount > MaxMemCount )
   ;	
	mov       eax,dword ptr [_MemCount]
	cmp       eax,dword ptr [_MaxMemCount]
	jle       short @4
   ;	
   ;		 MaxMemCount = MemCount ;
   ;	
	mov       edx,dword ptr [_MemCount]
	mov       dword ptr [_MaxMemCount],edx
   ;	
   ;	
   ;	  return True ;
   ;	
@4:
	mov       eax,1
   ;	
   ;	
   ;	}// GetNode()
   ;	
@5:
@3:
	pop       ebx
	pop       ebp
	ret 
_GetNode	endp
_ReturnNode	proc	near
?live1@192:
   ;	
   ;	void ReturnNode( nodePtr *h )
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	#if KNAPSACK_NODE_DEBUG > 0
   ;	  printf( "\n ReturnNode(): MemCount == %d", MemCount );
   ;	
@7:
	push      dword ptr [_MemCount]
	push      offset s@+55
	call      _printf
	add       esp,8
   ;	
   ;	#endif
   ;	
   ;	  free( *h );
   ;	
	mov       eax,dword ptr [ebp+8]
	push      dword ptr [eax]
	call      _free
	pop       ecx
   ;	
   ;	  MemCount-- ;
   ;	
	dec       dword ptr [_MemCount]
   ;	
   ;	
   ;	}// ReturnNode()
   ;	
@8:
	pop       ebp
	ret 
_ReturnNode	endp
_MemCheck	proc	near
?live1@272:
   ;	
   ;	BOOLEAN MemCheck()
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	  return (BOOLEAN)( MemCount == 0 );
   ;	
@9:
	cmp       dword ptr [_MemCount],0
	sete      al
	and       eax,1
   ;	
   ;	
   ;	}// MemCheck()
   ;	
@11:
@10:
	pop       ebp
	ret 
_MemCheck	endp
_setName	proc	near
?live1@320:
   ;	
   ;	BOOLEAN setName( nodePtr x, const char *z )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	mov       esi,dword ptr [ebp+12]
	mov       ebx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  if( x->name ) free( x->name ) ; // free any existing char* memory
   ;	
?live1@336: ; EBX = x, ESI = z
@12:
	cmp       dword ptr [ebx],0
	je        short @13
	push      dword ptr [ebx]
	call      _free
	pop       ecx
   ;	
   ;	
   ;	  if( z != NULL )
   ;	
@13:
	test      esi,esi
	je        short @14
   ;	
   ;	  {
   ;		 // allocate space for the name
   ;		 x->name = (char*)malloc( (strlen(z)+1) * sizeof(char) );
   ;	
	push      esi
	call      _strlen
	pop       ecx
	inc       eax
	push      eax
	call      _malloc
	pop       ecx
	mov       dword ptr [ebx],eax
   ;	
   ;		 if( x->name )
   ;	
	cmp       dword ptr [ebx],0
	je        short @15
   ;	
   ;		 {
   ;			strcpy( x->name, z );
   ;	
	push      esi
	push      dword ptr [ebx]
	call      _strcpy
	add       esp,8
   ;	
   ;			return True ;
   ;	
?live1@416: ; 
	mov       eax,1
	jmp       short @16
   ;	
   ;		 }
   ;		 else
   ;			  fprintf( stderr, " setName(): malloc error !\n" );
   ;	
@15:
	push      offset s@+86
	push      offset __streams+48
	call      _fprintf
	add       esp,8
   ;	
   ;	  }
   ;	
	jmp       short @17
   ;	
   ;	  else
   ;			fprintf( stderr, " setName(): parameter char* is NULL !\n" );
   ;	
@14:
	push      offset s@+114
	push      offset __streams+48
	call      _fprintf
	add       esp,8
   ;	
   ;	
   ;	  return False ;
   ;	
@17:
	xor       eax,eax
   ;	
   ;	
   ;	}// setName()
   ;	
@18:
@16:
	pop       esi
	pop       ebx
	pop       ebp
	ret 
_setName	endp
_appendName	proc	near
?live1@512:
   ;	
   ;	BOOLEAN appendName( nodePtr y, const char *z )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	push      edi
	mov       esi,dword ptr [ebp+12]
	mov       ebx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  char *temp ;
   ;	  int len = (y->name == NULL) ? 0 : strlen(y->name) ;
   ;	
?live1@528: ; EBX = y, ESI = z
@19:
	cmp       dword ptr [ebx],0
	jne       short @20
	xor       edi,edi
	jmp       short @21
@20:
	push      dword ptr [ebx]
	call      _strlen
	pop       ecx
	mov       edi,eax
   ;	
   ;	
   ;	  if( z != NULL )
   ;	
?live1@544: ; EBX = y, ESI = z, EDI = len
@21:
	test      esi,esi
	je        short @22
   ;	
   ;	  {
   ;		 // allocate space for the addition
   ;		 temp = (char*)realloc( y->name, (len+strlen(z)+1) * sizeof(char) );
   ;	
	push      esi
	call      _strlen
	pop       ecx
	add       eax,edi
	inc       eax
	push      eax
	push      dword ptr [ebx]
	call      _realloc
	add       esp,8
   ;	
   ;		 if( temp )
   ;	
?live1@576: ; EBX = y, ESI = z, EAX = temp
	test      eax,eax
	je        short @23
   ;	
   ;		 {
   ;			y->name = temp ;
   ;	
	mov       dword ptr [ebx],eax
   ;	
   ;			strcat( y->name, z );
   ;	
?live1@608: ; EBX = y, ESI = z
	push      esi
	push      dword ptr [ebx]
	call      _strcat
	add       esp,8
   ;	
   ;			return True ;
   ;	
?live1@624: ; 
	mov       eax,1
	jmp       short @24
   ;	
   ;		 }
   ;		 else
   ;			  fprintf( stderr, " appendName(): realloc error !\n" );
   ;	
@23:
	push      offset s@+153
	push      offset __streams+48
	call      _fprintf
	add       esp,8
   ;	
   ;	  }
   ;	
	jmp       short @25
   ;	
   ;	  else
   ;			fprintf( stderr, " appendName(): parameter char* is NULL !\n" );
   ;	
@22:
	push      offset s@+185
	push      offset __streams+48
	call      _fprintf
	add       esp,8
   ;	
   ;	
   ;	  return False ;
   ;	
@25:
	xor       eax,eax
   ;	
   ;	
   ;	}// appendName()
   ;	
@26:
@24:
	pop       edi
	pop       esi
	pop       ebx
	pop       ebp
	ret 
_appendName	endp
_displayNode	proc	near
?live1@720:
   ;	
   ;	void displayNode( nodePtr x )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	mov       ebx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  printf( "%13s: ", x->name ? x->name : "NO NAME ! " );
   ;	
?live1@736: ; EBX = x
@27:
	cmp       dword ptr [ebx],0
	je        short @28
	mov       eax,dword ptr [ebx]
	jmp       short @29
@28:
	mov       eax,offset s@+234
@29:
	push      eax
	push      offset s@+227
	call      _printf
	add       esp,8
   ;	
   ;	  printf( " level %2d ; bound == %8.3f ;", x->level, x->bound );
   ;	
	fld       dword ptr [ebx+20]
	add       esp,-8
	fstp      qword ptr [esp]
	push      dword ptr [ebx+4]
	push      offset s@+245
	call      _printf
	add       esp,16
   ;	
   ;	  printf( " profit == %6d ; weight == %6d ; pw == %7.3f \n",
   ;	
	fld       dword ptr [ebx+16]
	add       esp,-8
	fstp      qword ptr [esp]
	push      dword ptr [ebx+12]
	push      dword ptr [ebx+8]
	push      offset s@+275
	call      _printf
	add       esp,20
   ;	
   ;					x->profit, x->weight, x->pw );
   ;	
   ;	}// displayNode()
   ;	
?live1@784: ; 
@30:
	pop       ebx
	pop       ebp
	ret 
_displayNode	endp
_copyNode	proc	near
?live1@800:
   ;	
   ;	BOOLEAN copyNode( nodePtr m, const nodePtr n )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	mov       ebx,dword ptr [ebp+12]
	mov       esi,dword ptr [ebp+8]
   ;	
   ;	{
   ;	#if KNAPSACK_NODE_DEBUG > 0
   ;	  printf( "\n copyNode(): " );
   ;	
?live1@816: ; EBX = n, ESI = m
@31:
	push      offset s@+322
	call      _printf
	pop       ecx
   ;	
   ;	  displayNode( n );
   ;	
	push      ebx
	call      _displayNode
	pop       ecx
   ;	
   ;	#endif
   ;	
   ;	  if( !setName(m, n->name) )
   ;	
	push      dword ptr [ebx]
	push      esi
	call      _setName
	add       esp,8
	test      eax,eax
	jne       short @32
   ;	
   ;		 return False ;
   ;	
?live1@864: ; 
	xor       eax,eax
	jmp       short @33
   ;	
   ;	
   ;	  m->level  = n->level ;
   ;	
?live1@880: ; EBX = n, ESI = m
@32:
	mov       edx,dword ptr [ebx+4]
	mov       dword ptr [esi+4],edx
   ;	
   ;	  m->profit = n->profit ;
   ;	
	mov       ecx,dword ptr [ebx+8]
	mov       dword ptr [esi+8],ecx
   ;	
   ;	  m->weight = n->weight ;
   ;	
	mov       eax,dword ptr [ebx+12]
	mov       dword ptr [esi+12],eax
   ;	
   ;	  m->pw     = n->pw ;
   ;	
	mov       edx,dword ptr [ebx+16]
	mov       dword ptr [esi+16],edx
   ;	
   ;	  m->bound  = n->bound ;
   ;	
	mov       ecx,dword ptr [ebx+20]
	mov       dword ptr [esi+20],ecx
   ;	
   ;	
   ;	  return True ;
   ;	
?live1@960: ; 
	mov       eax,1
   ;	
   ;	
   ;	}// copyNode()
   ;	
@34:
@33:
	pop       esi
	pop       ebx
	pop       ebp
	ret 
_copyNode	endp
_initQueue	proc	near
?live1@992:
   ;	
   ;	void initQueue( PqPtr p )
   ;	
	push      ebp
	mov       ebp,esp
	mov       eax,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  p->nodes = NULL ;
   ;	
?live1@1008: ; EAX = p
@35:
	xor       edx,edx
	mov       dword ptr [eax],edx
   ;	
   ;	  p->size = 0 ;
   ;	
	xor       ecx,ecx
	mov       dword ptr [eax+4],ecx
   ;	
   ;	
   ;	}// initQueue()
   ;	
?live1@1040: ; 
@36:
	pop       ebp
	ret 
_initQueue	endp
_isEmptyQueue	proc	near
?live1@1056:
   ;	
   ;	BOOLEAN isEmptyQueue( PqPtr p )
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	  return (BOOLEAN)( p->nodes == NULL );
   ;	
@37:
	mov       eax,dword ptr [ebp+8]
	cmp       dword ptr [eax],0
	sete      al
	and       eax,1
   ;	
   ;	
   ;	}// isEmptyQueue()
   ;	
@39:
@38:
	pop       ebp
	ret 
_isEmptyQueue	endp
_insertNode	proc	near
?live1@1104:
   ;	
   ;	void insertNode( PqPtr p, nodePtr s )
   ;	
	push      ebp
	mov       ebp,esp
	push      ecx
	push      ebx
	push      esi
	mov       ebx,dword ptr [ebp+8]
	lea       esi,dword ptr [ebp-4]
   ;	
   ;	{
   ;	  nodePtr newnode ;
   ;	
   ;	  GetNode( &newnode );
   ;	
?live1@1120: ; EBX = p, ESI = &newnode
@40:
	push      esi
	call      _GetNode
	pop       ecx
   ;	
   ;	  copyNode( newnode, s );
   ;	
	push      dword ptr [ebp+12]
	push      dword ptr [esi]
	call      _copyNode
	add       esp,8
   ;	
   ;	
   ;	#if KNAPSACK_NODE_DEBUG > 0
   ;	  printf( "\n insertNode(): " );
   ;	
	push      offset s@+337
	call      _printf
	pop       ecx
   ;	
   ;	  displayNode( newnode );
   ;	
	push      dword ptr [esi]
	call      _displayNode
	pop       ecx
   ;	
   ;	#endif
   ;	
   ;	  newnode->next = NULL ;
   ;	
	mov       eax,dword ptr [esi]
	xor       edx,edx
	mov       dword ptr [eax+24],edx
   ;	
   ;	
   ;	  // insert the new node at the start of the linked list
   ;	  if( isEmptyQueue(p)  ||  newnode->bound >= p->nodes->bound )
   ;	
	push      ebx
	call      _isEmptyQueue
	pop       ecx
	test      eax,eax
	jne       short @42
	mov       ecx,dword ptr [esi]
	fld       dword ptr [ecx+20]
	mov       eax,dword ptr [ebx]
	fcomp     dword ptr [eax+20]
	fnstsw ax
	sahf
	jb        short @41
   ;	
   ;	  {
   ;		 newnode->next = p->nodes ;
   ;	
@42:
	mov       edx,dword ptr [esi]
	mov       ecx,dword ptr [ebx]
	mov       dword ptr [edx+24],ecx
   ;	
   ;		 p->nodes = newnode ;
   ;	
	mov       eax,dword ptr [esi]
	mov       dword ptr [ebx],eax
   ;	
   ;	  }
   ;	
?live1@1248: ; EBX = p
	jmp       short @43
   ;	
   ;	  else // need to find the position to insert the node
   ;		 {
   ;			nodePtr temp = p->nodes ;
   ;	
?live1@1264: ; EBX = p, ESI = &newnode
@41:
@44:
	mov       edx,dword ptr [ebx]
	jmp       short @46
   ;	
   ;			while( temp->next != NULL  &&  temp->next->bound > newnode->bound )
   ;			  temp = temp->next ;
   ;	
?live1@1280: ; EDX = temp, EBX = p, ESI = &newnode
@45:
	mov       edx,dword ptr [edx+24]
@46:
	cmp       dword ptr [edx+24],0
	je        short @47
	mov       ecx,dword ptr [edx+24]
	fld       dword ptr [ecx+20]
	mov       eax,dword ptr [esi]
	fcomp     dword ptr [eax+20]
	fnstsw ax
	sahf
	ja        short @45
   ;	
   ;	
   ;			newnode->next = temp->next ;
   ;	
@47:
	mov       ecx,dword ptr [esi]
	mov       eax,dword ptr [edx+24]
	mov       dword ptr [ecx+24],eax
   ;	
   ;			temp->next = newnode ;
   ;	
	mov       ecx,dword ptr [esi]
	mov       dword ptr [edx+24],ecx
   ;	
   ;		 }
   ;	
   ;	  p->size++ ;
   ;	
?live1@1344: ; EBX = p
@48:
@43:
	inc       dword ptr [ebx+4]
   ;	
   ;	
   ;	}// insertNode()
   ;	
?live1@1360: ; 
@49:
	pop       esi
	pop       ebx
	pop       ecx
	pop       ebp
	ret 
_insertNode	endp
_displayQueue	proc	near
?live1@1376:
   ;	
   ;	void displayQueue( PqPtr p )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	push      edi
	mov       eax,dword ptr [ebp+8]
	mov       edi,offset s@
   ;	
   ;	{
   ;	  int i=1 ;
   ;	
?live1@1392: ; EAX = p, EDI = &s@
@50:
	mov       esi,1
   ;	
   ;	  nodePtr temp = p->nodes ;
   ;	
?live1@1408: ; ESI = i, EAX = p, EDI = &s@
	mov       ebx,dword ptr [eax]
   ;	
   ;	
   ;	  printf( "\n Queue Elements: (size == %d)\n", p->size );
   ;	
?live1@1424: ; EBX = temp, ESI = i, EAX = p, EDI = &s@
	push      dword ptr [eax+4]
	lea       eax,dword ptr [edi+354]
	push      eax
	call      _printf
	add       esp,8
   ;	
   ;	  while( temp != NULL )
   ;	
?live1@1440: ; EBX = temp, ESI = i, EDI = &s@
	test      ebx,ebx
	je        short @52
   ;	
   ;	  {
   ;		 printf( "%d. ", i );
   ;	
@51:
	push      esi
	lea       edx,dword ptr [edi+386]
	push      edx
	call      _printf
	add       esp,8
   ;	
   ;		 displayNode( temp );
   ;	
	push      ebx
	call      _displayNode
	pop       ecx
   ;	
   ;		 temp = temp->next ;
   ;	
	mov       ebx,dword ptr [ebx+24]
   ;	
   ;		 i++ ;
   ;	
	inc       esi
	test      ebx,ebx
	jne       short @51
   ;	
   ;	  }
   ;	  puts( "" );
   ;	
?live1@1536: ; EDI = &s@
@52:
	lea       ecx,dword ptr [edi+391]
	push      ecx
	call      _puts
	pop       ecx
   ;	
   ;	
   ;	}// displayQueue()
   ;	
?live1@1552: ; 
@53:
	pop       edi
	pop       esi
	pop       ebx
	pop       ebp
	ret 
_displayQueue	endp
_removeNode	proc	near
?live1@1568:
   ;	
   ;	void removeNode( PqPtr p, nodePtr r )
   ;	
	push      ebp
	mov       ebp,esp
	push      ecx
	push      ebx
	mov       ebx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  nodePtr head ;
   ;	
   ;	  if( isEmptyQueue(p) )
   ;	
?live1@1584: ; EBX = p
@54:
	push      ebx
	call      _isEmptyQueue
	pop       ecx
	test      eax,eax
	je        short @55
   ;	
   ;	  {
   ;		 puts( "ERROR - dequeue from empty queue" );
   ;	
	push      offset s@+392
	call      _puts
	pop       ecx
   ;	
   ;		 exit( 1 );
   ;	
	push      1
	call      _exit
	pop       ecx
   ;	
   ;	  }
   ;	
   ;	  // take the first member of the priority queue
   ;	  head = p->nodes ;
   ;	
@55:
	mov       eax,dword ptr [ebx]
	mov       dword ptr [ebp-4],eax
   ;	
   ;	#if KNAPSACK_NODE_DEBUG > 0
   ;	  printf( "\n removeNode(): " );
   ;	
	push      offset s@+425
	call      _printf
	pop       ecx
   ;	
   ;	  displayNode( head );
   ;	
	push      dword ptr [ebp-4]
	call      _displayNode
	pop       ecx
   ;	
   ;	#endif
   ;	
   ;	  p->nodes = p->nodes->next ;
   ;	
	mov       edx,dword ptr [ebx]
	mov       ecx,dword ptr [edx+24]
	mov       dword ptr [ebx],ecx
   ;	
   ;	
   ;	  copyNode( r, head );
   ;	
	push      dword ptr [ebp-4]
	push      dword ptr [ebp+12]
	call      _copyNode
	add       esp,8
   ;	
   ;	  ReturnNode( &head );
   ;	
	lea       eax,dword ptr [ebp-4]
	push      eax
	call      _ReturnNode
	pop       ecx
   ;	
   ;	
   ;	  p->size-- ;
   ;	
	dec       dword ptr [ebx+4]
   ;	
   ;	
   ;	}// removeNode()
   ;	
?live1@1744: ; 
@56:
	pop       ebx
	pop       ecx
	pop       ebp
	ret 
_removeNode	endp
_deleteQueue	proc	near
?live1@1760:
   ;	
   ;	void deleteQueue( PqPtr p )
   ;	
	push      ebp
	mov       ebp,esp
	mov       eax,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  if( p->nodes == NULL  &&  p->size == 0 )
   ;	
?live1@1776: ; EAX = p
@57:
	cmp       dword ptr [eax],0
	jne       short @58
	cmp       dword ptr [eax+4],0
	jne       short @58
   ;	
   ;		 puts( "Queue is Empty" );
   ;	
?live1@1792: ; 
	push      offset s@+442
	call      _puts
	pop       ecx
	jmp       short @59
   ;	
   ;	  else
   ;			printf( " deleteQueue(): ERROR: p->nodes == %p and p->size == %d !!",
   ;	
?live1@1808: ; EAX = p
@58:
	push      dword ptr [eax+4]
	push      dword ptr [eax]
	push      offset s@+457
	call      _printf
	add       esp,12
   ;	
   ;				p->nodes, p->size );
   ;	
   ;	  if( !MemCheck )
   ;	
?live1@1824: ; 
@59:
	mov       eax,offset _MemCheck
	test      eax,eax
	jne       short @60
   ;	
   ;		 printf( " MemCheck ERROR: MemCount == %d !!", MemCount );
   ;	
	push      dword ptr [_MemCount]
	push      offset s@+516
	call      _printf
	add       esp,8
   ;	
   ;	
   ;	  printf( "Max MemCount == %d \n", MaxMemCount );
   ;	
@60:
	push      dword ptr [_MaxMemCount]
	push      offset s@+551
	call      _printf
	add       esp,8
   ;	
   ;	
   ;	}// deleteQueue()
   ;	
@61:
	pop       ebp
	ret 
_deleteQueue	endp
_initNodeArray	proc	near
?live1@1888:
   ;	
   ;	BOOLEAN initNodeArray( nodeArray *a, const int size )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	push      edi
	mov       esi,dword ptr [ebp+12]
	mov       ebx,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  int i ;
   ;	
   ;	  *a = (nodeArray)malloc( size * sizeof(node) );
   ;	
?live1@1904: ; EBX = a, ESI = size
@62:
	imul      eax,esi,28
	push      eax
	call      _malloc
	pop       ecx
	mov       dword ptr [ebx],eax
   ;	
   ;	  if( !(*a) )
   ;	
	cmp       dword ptr [ebx],0
	jne       short @63
   ;	
   ;	  {
   ;		 fprintf( stderr, " Memory allocation error for nodeArray !\n" );
   ;	
?live1@1936: ; 
	push      offset s@+572
	push      offset __streams+48
	call      _fprintf
	add       esp,8
   ;	
   ;		 return False ;
   ;	
	xor       eax,eax
	jmp       short @64
   ;	
   ;	  }
   ;	
   ;	  // make sure every char* starts as NULL
   ;	  for( i=0; i < size ; i++ )
   ;	
?live1@1968: ; EBX = a, ESI = size
@63:
	xor       eax,eax
	cmp       esi,eax
	jle       short @66
   ;	
   ;		 ((*a)+i)->name = NULL ;
   ;	
?live1@1984: ; EAX = i, EBX = a, ESI = size
@65:
	mov       edx,eax
	shl       edx,3
	sub       edx,eax
	mov       ecx,dword ptr [ebx]
	xor       edi,edi
	mov       dword ptr [ecx+4*edx],edi
	inc       eax
	cmp       esi,eax
	jg        short @65
   ;	
   ;	
   ;	  return True ;
   ;	
?live1@2000: ; 
@66:
	mov       eax,1
   ;	
   ;	
   ;	}// initNodeArray()
   ;	
@68:
@64:
	pop       edi
	pop       esi
	pop       ebx
	pop       ebp
	ret 
_initNodeArray	endp
_displayNodeArray	proc	near
?live1@2032:
   ;	
   ;	void displayNodeArray( const nodeArray nodes, const int size )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	push      edi
	mov       esi,dword ptr [ebp+12]
	mov       edi,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  int i=0 ;
   ;	
?live1@2048: ; ESI = size, EDI = nodes
@69:
	xor       ebx,ebx
   ;	
   ;	#if KNAPSACK_NODE_DEBUG > 1
   ;	  puts( "\n displayNodeArray()" );
   ;	  printf( "nodeArray == %p \n", nodes );
   ;	#endif
   ;	  if( size > 0 )
   ;	
?live1@2064: ; EBX = i, ESI = size, EDI = nodes
	test      esi,esi
	jle       short @70
   ;	
   ;	  {
   ;		 printf( " NodeArray Elements: (size == %d)\n", size );
   ;	
	push      esi
	push      offset s@+614
	call      _printf
	add       esp,8
   ;	
   ;		 for( ; i < size; i++ )
   ;	
	cmp       esi,ebx
	jle       short @74
   ;	
   ;		 {
   ;			printf( "%3d. ", i+1 );
   ;	
@71:
	lea       eax,dword ptr [ebx+1]
	push      eax
	push      offset s@+649
	call      _printf
	add       esp,8
   ;	
   ;			displayNode( nodes+i );
   ;	
	imul      edx,ebx,28
	add       edx,edi
	push      edx
	call      _displayNode
	pop       ecx
	inc       ebx
	cmp       esi,ebx
	jg        short @71
   ;	
   ;		 }
   ;	  }
   ;	
?live1@2160: ; 
	jmp       short @74
   ;	
   ;	  else
   ;			printf( "\n displayNodeArray(): passed array size == %d !\n", size );
   ;	
?live1@2176: ; ESI = size
@70:
	push      esi
	push      offset s@+655
	call      _printf
	add       esp,8
   ;	
   ;	
   ;	}// displayNodeArray()
   ;	
?live1@2192: ; 
@74:
@75:
	pop       edi
	pop       esi
	pop       ebx
	pop       ebp
	ret 
_displayNodeArray	endp
_deleteNodeArray	proc	near
?live1@2208:
   ;	
   ;	void deleteNodeArray( nodeArray b, const int size )
   ;	
	push      ebp
	mov       ebp,esp
	push      ebx
	push      esi
	push      edi
	mov       edi,dword ptr [ebp+12]
	mov       esi,dword ptr [ebp+8]
   ;	
   ;	{
   ;	  int i ;
   ;	
   ;	  for( i=0; i < size ; i++ )
   ;	
?live1@2224: ; ESI = b, EDI = size
@76:
	xor       ebx,ebx
	cmp       edi,ebx
	jle       short @78
   ;	
   ;		 free( b[i].name );
   ;	
?live1@2240: ; EBX = i, ESI = b, EDI = size
@77:
	mov       eax,ebx
	shl       eax,3
	sub       eax,ebx
	push      dword ptr [esi+4*eax]
	call      _free
	pop       ecx
	inc       ebx
	cmp       edi,ebx
	jg        short @77
   ;	
   ;	
   ;	  free( b );
   ;	
?live1@2256: ; ESI = b
@78:
	push      esi
	call      _free
	pop       ecx
   ;	
   ;	
   ;	}// deleteNodeArray()
   ;	
?live1@2272: ; 
@80:
	pop       edi
	pop       esi
	pop       ebx
	pop       ebp
	ret 
_deleteNodeArray	endp
_compareNode	proc	near
?live1@2288:
   ;	
   ;	int compareNode( const void *m, const void *n )
   ;	
	push      ebp
	mov       ebp,esp
   ;	
   ;	{
   ;	  const node *a = m ;
   ;	
@81:
	mov       edx,dword ptr [ebp+8]
   ;	
   ;	  const node *b = n ;
   ;	
?live1@2320: ; EDX = a
	mov       ecx,dword ptr [ebp+12]
   ;	
   ;	
   ;	  // sort in descending order
   ;	  if( a->pw > b->pw )
   ;	
?live1@2336: ; EDX = a, ECX = b
	fld       dword ptr [edx+16]
	fcomp     dword ptr [ecx+16]
	fnstsw ax
	sahf
	jbe       short @82
   ;	
   ;		 return -1 ;
   ;	
?live1@2352: ; 
	or        eax,-1
@86:
	pop       ebp
	ret 
   ;	
   ;	
   ;	  if( a->pw == b->pw )
   ;	
?live1@2368: ; EDX = a, ECX = b
@82:
	fld       dword ptr [edx+16]
	fcomp     dword ptr [ecx+16]
	fnstsw ax
	sahf
	jne       short @84
   ;	
   ;		 return 0 ;
   ;	
?live1@2384: ; 
	xor       eax,eax
@87:
	pop       ebp
	ret 
   ;	
   ;	
   ;	  return 1 ;
   ;	
@84:
	mov       eax,1
   ;	
   ;	
   ;	}// compareNode()
   ;	
@85:
@83:
	pop       ebp
	ret 
_compareNode	endp
_TEXT	ends
_DATA	segment dword public use32 'DATA'
s@	label	byte
	db	10
	;	s@+1:
	db	"GetNode(): MemCount == %d ",0
	;	s@+28:
	db	"GetNode(): malloc error !",10,0,10
	;	s@+56:
	db	" ReturnNode(): MemCount == %d",0
	;	s@+86:
	db	" setName(): malloc error !",10,0
	;	s@+114:
	db	" setName(): parameter char* is NULL !",10,0
	;	s@+153:
	db	" appendName(): realloc error !",10,0
	;	s@+185:
	db	" appendName(): parameter char* is NULL !",10,0
	;	s@+227:
	db	"%13s: ",0
	;	s@+234:
	db	"NO NAME ! ",0
	;	s@+245:
	db	" level %2d ; bound == %8.3f ;",0
	;	s@+275:
	db	" profit == %6d ; weight == %6d ; pw == %7.3f ",10,0,10
	;	s@+323:
	db	" copyNode(): ",0,10
	;	s@+338:
	db	" insertNode(): ",0,10
	;	s@+355:
	db	" Queue Elements: (size == %d)",10,0
	;	s@+386:
	db	"%d. ",0,0
	;	s@+392:
	db	"ERROR - dequeue from empty queue",0,10
	;	s@+426:
	db	" removeNode(): ",0
	;	s@+442:
	db	"Queue is Empty",0
	;	s@+457:
	db	" deleteQueue(): ERROR: p->nodes == %p and p->size == %d !!"
	db	0
	;	s@+516:
	db	" MemCheck ERROR: MemCount == %d !!",0
	;	s@+551:
	db	"Max MemCount == %d ",10,0
	;	s@+572:
	db	" Memory allocation error for nodeArray !",10,0
	;	s@+614:
	db	" NodeArray Elements: (size == %d)",10,0
	;	s@+649:
	db	"%3d. ",0,10
	;	s@+656:
	db	" displayNodeArray(): passed array size == %d !",10,0
	align	4
_DATA	ends
_TEXT	segment dword public use32 'CODE'
_TEXT	ends
	extrn	__streams:byte
	public	_MemCount
	public	_MaxMemCount
	public	_GetNode
	extrn	_printf:near
	extrn	_malloc:near
	extrn	_fprintf:near
	public	_ReturnNode
	extrn	_free:near
	public	_MemCheck
	public	_setName
	extrn	_strlen:near
	extrn	_strcpy:near
	public	_appendName
	extrn	_realloc:near
	extrn	_strcat:near
	public	_displayNode
	public	_copyNode
	public	_initQueue
	public	_isEmptyQueue
	public	_insertNode
	public	_displayQueue
	extrn	_puts:near
	public	_removeNode
	extrn	_exit:near
	public	_deleteQueue
	public	_initNodeArray
	public	_displayNodeArray
	public	_deleteNodeArray
	public	_compareNode
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
	?debug	D "node.c" 11909 36938
	end
