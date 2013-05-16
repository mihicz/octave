## Copyright (C) 2011 jakub
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with Octave; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## ssmotor

## Author: jakub <jakub@JAKUB-BEBF894F0>
## Created: 2011-09-16

  vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3,"InitialStep",0.02,"MaxStep",0.02);
  
		  % vopt = odeset();
[t,x]=ode23(@ssmot1,[0,0.2],[0;0],vopt);
plot(t,x); grid on;
title('Rozbeh SS motoru'); xlabel('time [s]'); legend('proud','otacky');