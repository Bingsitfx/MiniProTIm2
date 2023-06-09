import TopNavbar from './topNavbar'

const Layout=({ children }: any)=>{
    return (
        <>
        <TopNavbar/>
        {children}
        </>
    )
}

export default Layout