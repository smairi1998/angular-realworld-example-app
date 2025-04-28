import { HttpInterceptorFn } from "@angular/common/http";
import { environment } from "../../../environments/environment"; // Adjust the path if needed

export const apiInterceptor: HttpInterceptorFn = (req, next) => {
  // Clone the request and prepend the base URL from the environment config
  const apiReq = req.clone({
    url: `${environment.apiBaseUrl}${req.url}`,
  });

  return next(apiReq);
};
