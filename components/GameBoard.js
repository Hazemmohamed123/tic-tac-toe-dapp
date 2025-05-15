import { useState } from 'react';
import { usePrepareContractWrite, useContractWrite } from 'wagmi';
import TicTacToeAbi from '../abi/TicTacToe.json';

const CONTRACT_ADDRESS = "0x992120d176521eDf77043CC74ed939657F8E4fD9";

export function GameBoard() {
  const [selectedCell, setSelectedCell] = useState(null);

  const { config } = usePrepareContractWrite({
    address: CONTRACT_ADDRESS,
    abi: TicTacToeAbi,
    functionName: 'makeMove',
    args: selectedCell !== null ? [selectedCell] : undefined,
    // تفادي تحضير الاتصال إذا لم يتم اختيار خانة بعد
    enabled: selectedCell !== null,
  });

  const { write, isLoading, error } = useContractWrite(config);

  const handleClick = (cellIndex) => {
    setSelectedCell(cellIndex);
  };

  return (
    <div>
      {[0, 1, 2, 3, 4, 5, 6, 7, 8].map((index) => (
        <button
          key={index}
          onClick={() => {
            handleClick(index);
            write?.();
          }}
          disabled={isLoading}
        >
          {isLoading && selectedCell === index ? 'Processing...' : `Play at cell ${index}`}
        </button>
      ))}

      {error && <p style={{ color: 'red' }}>Error: {error.message}</p>}
    </div>
  );
}

