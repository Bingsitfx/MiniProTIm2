import NavBar from './komponen/navBar'


const Layout=({ children }: any)=>{
    return (
        <>
        <NavBar/>
        {children}
        </>
    )
}

export default Layout