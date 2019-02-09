export class ApiRequestError extends Error {}
export class ApiSessionExpired extends ApiRequestError {}
export class ApiServerDenied extends ApiRequestError {}