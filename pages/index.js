import Head from 'next/head';
import { ConnectWallet } from '@/components/ConnectWallet';

export default function Home() {
  return (
    <>
      <Head>
        <title>Tic Tac Toe DApp</title>
      </Head>
      <main>
        <h1>Welcome to Tic Tac Toe DApp</h1>
        <ConnectWallet />
        {/* Game Board will go here */}
      </main>
    </>
  );
}