import './styles.css';

const App = () => {
    return (
        <div>
            <header className="header">
                <h1>Welcome to My Home Page</h1>
                <p>This is a simple and beautiful full-screen layout.</p>
                <a href="#about" className="btn">Learn More</a>
            </header>

            <section id="about" className="about">
                <h2>About</h2>
                <p>This is a simple page designed with React and Vite to demonstrate a full-screen layout.</p>
            </section>
        </div>
    );
};

export default App;