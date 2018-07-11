pragma solidity 0.4.24;
   
contract IndexOf {
    /**
     * @author ixnay.nayix@gmail.com
     *
     * @dev Returns the index of the first occurrence of `needle` in `haystack`,
     *      or -1 if `needle` is not found in `haystack`.
     *
     * Input strings may be of any length <2^255.
     *
     * @param haystack The string to search.
     * @param needle The string to search for.
     * @return The index of `needle` in `haystack`, or -1 if not found.
     */
    function indexOf(string haystack, string needle) public pure returns(int) {
        uint haystackLen = bytes(haystack).length;
        uint needleLen = bytes(needle).length;
        int[] memory helper = new int[](127);
        int limit;
        
        if((haystackLen == 0) || (needleLen == 0)  ){
            return 0;
        }
        
        //Preprocessing
        uint i;
        int j;
        
        for(i = 0; i < 127; i++) 
            helper[i] = ~0; 
            
        j = 1;
        for(i = 0; i < needleLen; i++ ) { 
            helper[uint(bytes(needle)[i])] &= ~j; 
            limit |= j; 
            j <<= 1;
        } 
        limit = ~(limit>>1); 
        
        // Searching 
        int state;
        state = ~0;
        for (j = 0; j < int(haystackLen); j++) { 
            state = (state<<1) | helper[uint(bytes(haystack)[uint(j)])]; 
            if (state < limit) 
                return int(uint(j) - needleLen + 1); 
        }
        return -1;
    }
}