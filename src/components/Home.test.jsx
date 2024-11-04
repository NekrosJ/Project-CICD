// src/components/Home.test.jsx
import React from 'react';
import { render, screen } from '@testing-library/react';
import Home from './Home';

test('renders home page with welcome message', () => {
  render(<Home />);
  const headingElement = screen.getByText(/Welcome to the Home Page/i);
  expect(headingElement).toBeInTheDocument();
});
