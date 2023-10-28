class EndPoints {
  static const BASE_URL = 'https://dev.catchacoach.systems/api';
  static const getImageFormPostMan = 'https://dev.catchacoach.systems';
  static const login = '/auth/local/';
  static const register = '/auth/local/register';
  static const updateCoach = '/coaches/';
  static const getProfileData = '/users/me';
  static const getProfileDataWithLanguages = '/users/me?populate[spokenLanguages]=true&populate[appLanguage]=true';
  static const getIdImage = '/upload';
  static const getAllSports = '/sports?locale=en';
  static const updateCoachSports = '/coach-sports';
  static const paymentInterval = '/payment-intervals?local=EN';
  static const currency = '/currencies?locale=en';
  static const paymentMethod =
      '/payment-methods?local=en&populate[picture]=true';
  static const questions = '/trainee-questions';
  static const answers = '/answers';

  static const degree_edu = '/edu-degrees';
  // static const questions = '/questions';
  static const languages = '/languages';
  static const coachUsers = '/users/';
  static const traineeUsers = '/users/';
  static const getMultiImage = '/upload?';
  static const getAllGoals =
      '/goals?locale=en&populate[picture][fields][0]=url&sort[0]=id&fields[0]=name&populate[picture]=true';
  static const getAllLanguages = '/languages';
  static const getAllSportsTrainee = '/sports?locale=en';
  static const addSportsTrainee = '/trainee-sports';
  static const updateTrainee = '/trainees';

  static const updateLanguage = '/users/';
  static const searchForSport = '/sports?';

  static const getAllCities = '/cities';
  static const programs = '/programs';

  static const questionsService = '/questions';

  static const baseImageUrl = 'https://dev.catchacoach.systems';

  static const emailExist = '/users/count';

  static const deleteAllQuestions = '/questions/delete-all';
  static const deleteAllOffers = '/programs/delete-all';
  static const deleteAllCertifications = '/certificates/delete-all';

  static const deleteAllCoachSports = '/coach-sports/delete-all';

  static const searchCoach = '/coaches/';
  static const searchCoachBySport = '/coach-sports';
  static const yearsList = '/years-lists';

  static int coachId = 0;
  static var CoachProfileUrl =
      "/coaches/$coachId?populate[sports][populate][0]=sport&populate[paymentMethods][populate]=true&populate[paymentIntervals][populate]=true&populate[questions][populate]=true&populate[currencies][populate]=true&populate[user][populate][0]=spokenLanguages&populate[profilePicture][populate]=true&populate[city]=true&populate[country]=true&populate[coverPhoto]=true&populate[followings]=true&populate[user][populate][1]=coach_followers&populate[programs][populate][0]=true";

  static var listOfQuestionsCoach = '/questions?filters[coach]=1';
  static var listOfFollowersCoach = '/coach-followers?filters[followee]=$coachId&fields[0]=id';
  static var listOfFollowingsCoach = '/coach-followers?filters[follower]=$coachId&fields[0]=id';

  static const sortingList = '/config-sorts';
  static const sortingNewList = '/sort-configs';
  static var certificateUrl =
      "/certificates/?populate[certFile]=true&filters[coach]=$coachId";

  static const confirmEmail = '/auth/send-email-confirmation';
  static const confirmEmailCode = '/auth/email-confirmation';

  static const forgetPasswordConfirm = '/auth/forgot-password';
  static const checkCodeConfirm = '/users-permissionsusers/checkforPasswordToken';
  static const forgetPasswordConfirmCode = '/auth/reset-password';

  static const updateEmail = '/users-permissionsusers/updateUnconfirmedEmail';
}
