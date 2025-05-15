import '@/styles/globals.css';
import { WagmiConfig, createConfig, configureChains } from 'wagmi';
import { mainnet, goerli } from 'wagmi/chains';
import { publicProvider } from 'wagmi/providers/public';
import { Web3Modal } from '@web3modal/react';

const { chains, publicClient } = configureChains([goerli], [publicProvider()]);

const wagmiConfig = createConfig({
  autoConnect: true,
  publicClient,
});

export default function App({ Component, pageProps }) {
  return (
    <WagmiConfig config={wagmiConfig}>
      <Component {...pageProps} />
      <Web3Modal projectId="YOUR_PROJECT_ID" ethereumClient={wagmiConfig} />
    </WagmiConfig>
  );
}
