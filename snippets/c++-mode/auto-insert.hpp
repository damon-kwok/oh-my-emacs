/// `(buffer-name)` --- This is where you apply your OCD.
//
// Copyright (C) 2009-`(format-time-string "%Y")` damon-kwok
//
// Author: `(user-login-name)` <damon-kwok@outlook.com>
// Date: `(format-time-string "%Y-%m-%d")`
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//						 
// Code:
//
#ifndef __`(upcase (s-snake-case (ome-bufname-no-ext)))`_H__
#define __`(upcase (s-snake-case (ome-bufname-no-ext)))`_H__

// #pragma once

//
#include <cstdio>
//
// namespace ${1:Namespace}
//{
class ${2:`(ome-bufname-no-ext)`} final
{
public:
	$2(const $2 &) = delete;
	$2 &operator=(const $2 &) = delete;
    $2(){}

public:
	void trace() const
	{
		std::cout<<"`(buffer-name)`-$2: trace"<<std::endl;
	}
	
private:
    $0
};
// }
//
#endif //#ifndef __`(upcase (s-snake-case (ome-bufname-no-ext)))`_H__
//`(buffer-name)` ends here

