library global;

const baseUrl = 'https://api.themoviedb.org/3/movie/';
const imagesUrl = 'https://image.tmdb.org/t/p/';
const apiKey = 'Your_TMDb_API_key';

const language = '&language=en-EN';
const region = '&region=US';

const upcomingUrl =
    '${baseUrl}upcoming?api_key=${apiKey}$language$region';
const popularUrl =
    '${baseUrl}popular?api_key=${apiKey}$language$region';
const topRatedUrl =
    '${baseUrl}top_rated?api_key=${apiKey}$language$region';
const nowPlayingUrl =
    '${baseUrl}now_playing?api_key=${apiKey}$language$region';
const trendingUrl =
    'https://api.themoviedb.org/3/trending/movie/week?api_key=${apiKey}';
const personUrl =
    'https://api.themoviedb.org/3/person/';