pragma solidity 0.4.24;

contract HexDecoder {
    /**
     * @author ixnay.nayix@gmail.com
     * 
     * @dev Decodes a hex-encoded input string, returning it in binary.
     *
     * Input strings may be of any length, but will always be a multiple of two
     * bytes long, and will not contain any non-hexadecimal characters.
     *
     * @param input The hex-encoded input.
     * @return The decoded output.
     */
    function decode(string input) public pure returns(bytes output) {
        uint len = bytes(input).length;
        uint index;
        output = new bytes(len/2);
        bytes32 slotString;
        bytes32 secondSlotString;
        //Compact 2 bytes32 array for decoding in parallel an store it on slotString array
        for(uint i = 0; i < len ; i = i+64){
            uint numBytes = ((len-i)>=64)?64:len-i;
            for(uint j = 0; j < numBytes ;j = j+2){
                slotString = slotString>>8 | bytes(input)[j+i];
                secondSlotString = bytes(input)[j+i+1] | secondSlotString>>8;    
            }   
            slotString = bytes32((uint(slotString&0x4040404040404040404040404040404040404040404040404040404040404040)>>6)*9 + uint(slotString&0x0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F));
            secondSlotString = bytes32(uint(secondSlotString&0x0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F) + (uint(secondSlotString&0x4040404040404040404040404040404040404040404040404040404040404040)>>6)*9);
            slotString = bytes32(uint(slotString)*16 + uint(secondSlotString));
            numBytes = numBytes>>1;
            index = i>>1;
            for(j = 0;j<numBytes;j = j+2){
                output[index+j] = bytes1(slotString<<8*(numBytes-1-j));
                output[index+j+1] = bytes1(slotString<<8*(numBytes-2-j));
            }  
        }
    }
}