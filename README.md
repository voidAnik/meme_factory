# Meme Factory

## Overview

Meme Factory is a DEMO Flutter application that showcases a collection of memes with features such as search functionality, meme details, and image editing capabilities.

## Features

- **Display Memes**: All memes are displayed with their names and images.
- **Search Functionality**: A search bar allows for local searching by meme names.
- **Meme Details**: Clicking on a meme opens a detailed view with editing options.
- **Image Editing**: Users can crop, rotate, apply filters, and blur the meme images.
- **Signature Feature**: Users can add a signature above the image.
- **Save Functionality**: Edited images can be saved to the device's gallery and a specified external storage location.
- **Offline Caching**: Memes are stored locally using SQLite for improved performance and offline access. Also Images are cached for improved performance and faster loading times.
- **Pagination/Infinite Scrolling**: The app implements pagination to load memes incrementally, enhancing the user experience by reducing initial load times.
- **Light/Dark Theme**: The app supports both light and dark themes for a better user experience.

## Architecture

- **Feature-Based BLoC Architecture**: The app is structured using a feature-based BLoC architecture for better maintainability and scalability.
- **SOLID Principles**: The codebase adheres to SOLID principles to promote clean design.
- **Dependency Injection**: The application employs dependency injection for efficient resource management.
- **Go Router**: Navigation management is handled using `go_router` for seamless routing.
- **State Management**: BLoC is utilized for effective state management across the application.

## Finding the Release APK

You can find the release APK in the [Releases](https://github.com/voidAnik/meme_factory/releases/tag/pre-release) section of this repository.

## Screenshots

<p float="left">
  <img src="/ss/ss1.png" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/ss/ss2.png" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/ss/ss3.png" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/ss/ss4.png" width="150" />&nbsp;&nbsp;&nbsp;
  <img src="/ss/ss5.png" width="150" />
</p>




