pragma solidity 0.4.24;

contract Unique {
    /**
     * @author ixnay.nayix@gmail.com
     * 
     * @dev Removes all but the first occurrence of each element from a list of
     * integers, preserving the order of original elements, and returns the list.
     *
     * The input list may be of any length.
     *
     * @param input The list of integers to uniquify.
     * @return The input list, with any duplicate elements removed.
    */
    function uniquify(uint[] input) public pure returns(uint[] ret){
        uint counter;
        bool flagZero;
        uint inputLen = input.length;
        uint element;
        uint indexTable;
        uint[256] memory firstTable;
        uint[256] memory secondTable;
        uint[] memory index = new uint[](inputLen);

        if(inputLen < 2)
            return input;

        for(uint i = 0; i < inputLen; i++){
            element = input[i];
            indexTable = element & 255;

            if(element != 0 && firstTable[indexTable]==0){
                firstTable[indexTable] = element;
                index[counter] = element;
                counter++;
                continue;
            }
            if(element!=firstTable[indexTable] && firstTable[indexTable]!=0){
                secondTable[indexTable] = element;
                index[counter] = element;
                counter++;
                continue;
            }
            if(element == 0 && !flagZero){
                flagZero = true;
                firstTable[indexTable] = 0;
                index[counter] = 0;
                counter++;
            }
        }

        ret = new uint[](counter);
        if(counter%2 == 1){
            for(i = 0; i < counter; i++)
                ret[i] = index[i];
        }
        else
        {
            for(i = 0; i < counter; i = i+2){
                ret[i] = index[i];
                ret[i+1] = index[i+1];
            }
        }
    }
}