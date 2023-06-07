import '@/styles/globals.css'
import type { AppProps } from 'next/app'
import Layout from './shared/layout'

export default function App({ Component, pageProps }: AppProps) {
  // <Component {...pageProps} />
  return (
    <Layout>
        <Component {...pageProps} />
      </Layout>
  )
}
