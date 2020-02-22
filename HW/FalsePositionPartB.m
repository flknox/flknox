function [ r ] = FalsePositionPartB( a, b, N, eps_step, eps_abs )
    % Check that that neither end-point is a root
    % and if f(a) and f(b) have the same sign, throw an exception.
fa = a^3+(a-3);
fb = b^3+(b-3);
y = @(x) x^3+(x-3);    
    if ( fa == 0 )
	r = a;
	return;
    elseif ( fb == 0 )
	r = b;
	return;
    elseif ( fa * fb > 0 )
        disp('Error'); 
    end

    % We will iterate N times and if a root was not
    % found after N iterations, an exception will be thrown.

    c_old = Inf;

    for k = 1:N
        % Find the false position
        c = b -((a*fb - b*fb)/(fa - fb));
        fc = exp(-(c))-3;

        % Check if we found a root or whether or not
        % we should continue with:
        %          [a, c] if f(a) and f(c) have opposite signs, or
        %          [c, b] if f(c) and f(b) have opposite signs.

        if ( fc == 0 )
            r = c;
            return;
        elseif ( fc*fa < 0 )
            b = c;
        else
            a = c;
        end

        % If |b - a| < eps_step, check whether or not
        %       |f(a)| < |f(b)| and |f(a)| < eps_abs and return 'a', or
        %       |f(b)| < eps_abs and return 'b'.

        if ( abs( c - c_old ) < eps_step )
            if ( abs( fa ) < abs( fb ) && abs( fa ) < eps_abs )
                r = a;
                return;
            elseif ( abs( fb ) < eps_abs )
                r = b;
                return;
            end
        end

	c_old = c;
    end
 figure();
    gride on;
    plot(y);
    error( 'the method did not converge' );
end