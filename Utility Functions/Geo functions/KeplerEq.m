function E = KeplerEq(M0, e)% E = KeplerEq(M, e);%% Function (vectorized) to iteratively solve Kepler's % equation for eccentric anomaly.%% Input:%   M - mean anomaly (rad) (vector)%   e - eccentricity (dimensionless) (nxm) or (1x1)% Output:%   E - eccentric anomaly (rad) (nxm)%% wrapToPi = @(x) mod(x + pi, 2 * pi) - pi;e = abs(e);M =  mod(M0 + pi, 2 * pi) - pi;Ms = sign(M);Mr = M0 - M;M = abs(M);% set convergence criteriontol = 1e-15;      % convergence criterionmax_iter = 10;    % max iteration m = 1;            % iteration counter initial valuedE = 1.0;         % set initial value of delta-E to fail convergengeE = M + (e .* sin(M)) ./ (1 - sin(M + e) + sin(M));    % set initial value of E while any(abs(dE) > tol) && (m <= max_iter)  dE = (E - e .* sin(E) - M) ./ (1 - e .* cos(E));  E = E - dE;         % update E  m = m + 1;          % increment iteration numbers  if m > max_iter     % check against maximum iterations allowed    fprintf(2, 'Warning message from KEPLR_EQ ...\n')    fprintf(2, 'Maximum iterations exceeded in solution of Kepler''s Equation.\n')    fprintf(2, 'Results may be invalid.\n\n')    return  end % ifend % whileE = Mr + E .* Ms;