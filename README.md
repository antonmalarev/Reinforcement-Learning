# Q-Learning Agent in a GridWorld Environment

This repository contains a Jupyter Notebook that demonstrates the implementation of a Q-learning agent in a simple 5x5 grid environment. The agent learns to navigate the grid to reach a goal while avoiding penalties for unnecessary moves or hitting walls.

## Demo

![Agent Demo](assets/agent_demo.gif)

## Overview

Q-learning is a reinforcement learning algorithm that enables an agent to learn an optimal policy for decision-making in an environment. The agent learns by interacting with the environment and updating its Q-values using the Bellman equation.

### Key Components

1. **Environment**: A 5x5 grid where the agent starts at `(0, 0)` and aims to reach the goal at `(4, 4)`.
   - **Rewards**:
     - `+10` for reaching the goal.
     - `-1` for each move (to encourage shorter paths).
     - `-10` for hitting walls.

2. **Agent**: A Q-learning agent that learns the optimal policy using:
   - **Learning rate (α)**: Determines how much new information overrides old information.
   - **Discount factor (γ)**: Balances immediate and future rewards.
   - **Exploration rate (ε)**: Balances exploration and exploitation.

3. **Q-Table**: A table that stores the Q-values for each state-action pair.

### Bellman Equation

The Q-values are updated using the Bellman equation:

$$
Q(S, A) = Q(S, A) + \alpha \left[ R + \gamma \max Q(S', A') - Q(S, A) \right]
$$

## Features

- **Environment Simulation**: A grid-based environment with rewards and penalties.
- **Q-Learning Agent**: Implements ε-greedy strategy for exploration and exploitation.
- **Training**: The agent is trained over 1000 episodes to learn the optimal policy.
- **Visualization**:
  - Policy grid showing the best action for each state.
  - Path taken by the agent in the final episode.
  - Reward progression over episodes (smoothed for better visualization).
- **Export**:
  - Saves the learned policy to `policy.json`.
  - Saves the last episode's moves to `last_moves.json`.

## How to Run

1. Clone the repository
2. Set up environment
3. Launch Notebook and view the results

## Outputs
Policy Grid: Displays the optimal action for each state.
Path Visualization: Shows the agent's path from start to goal.
Reward Plot: Tracks the agent's learning progress over episodes.
