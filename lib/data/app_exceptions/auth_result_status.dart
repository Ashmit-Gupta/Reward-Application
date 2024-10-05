enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  idTokenExpired,
  invalidIdToken,
  insufficientPermission,
  internalError,
  undefined, // for unhandled exceptions
}
