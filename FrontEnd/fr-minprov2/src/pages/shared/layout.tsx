import TopNavbar from './topNavBar'

const Layout=({ children }: any)=>{
    return (
        <>
        <TopNavbar/>
        {children}
        </>
    )
}

export default Layout