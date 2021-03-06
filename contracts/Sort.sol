pragma solidity 0.4.24;

contract Sort {
    /**
     * @author ixnay.nayix@gmail.com
     * 
     * @dev Sorts a list of integers in ascending order.
     *
     * The input list may be of any length.
     *
     * @param input The list of integers to sort.
     * @return The sorted list.
     */
    function sort(uint[] input) public pure returns(uint[]) {
        uint inputLen = input.length;
        bool ordered = true;
        bool inversedOrdered = true;

        //Filter to avoid processing empty input array
        if(inputLen == 0)
            return input;
        
        //Detecting pattern scenario where the input is already ordered
        uint n;
        while(n < inputLen-1){
            if(input[n]>input[n+1])
            {
                ordered = false;
                break;
            }    
            n++;
        }
        if(ordered)
            return input;

        n = 0;
        //Detecting pattern scenario where the input is inversed ordered
        while(n < inputLen-1){
            if(input[n]<input[n+1])
            {
                inversedOrdered = false;
                break;
            }    
            n++;
        }

        if(inversedOrdered){
            for(n = 0;n < inputLen/2;n = n+2){
                (input[n],input[inputLen-n-1]) = (input[inputLen-n-1],input[n]);
                (input[n+1],input[inputLen-n-2]) = (input[inputLen-n-2],input[n+1]);
            }
            return input;
        }   
        
        //Apply QuickSort algorithm with minor modifications in order to save GAS
        quickSort(input, 0, inputLen - 1);
        return input;
    }

    function quickSort(uint[] input, uint low, uint high) internal pure {
        uint i = low;
        uint j = high;
        uint pivot = input[(i + (j))/2];
        while (i <= j) {
            while (input[i] < pivot) i++;
            while (pivot < input[j]) j--;
            if (i <= j) {
                if(i!=j)
                    (input[j], input[i]) = (input[i], input[j]);
                i++;
                j--;
            }
        }
        if (low < j)
            quickSort(input, low, j);
        if (i < high)
            quickSort(input, i, high);
    }
}