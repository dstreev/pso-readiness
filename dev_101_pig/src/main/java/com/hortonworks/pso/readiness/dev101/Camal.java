/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.hortonworks.pso.readiness.dev101;

import org.apache.log4j.Logger;
import org.apache.pig.EvalFunc;
import org.apache.pig.data.Tuple;

import java.io.IOException;

public class Camal extends EvalFunc<String> {
    static private Logger logger = org.apache.log4j.Logger.getLogger(Camal.class.getName());

    @Override
    public String exec(Tuple objects) throws IOException {
        String value = (String)objects.get(0);

        byte[] breakdown = value.getBytes();

        StringBuilder sb = new StringBuilder();

        for (int i=0;i<breakdown.length;i++) {
            byte[] check = new byte[1];
            check[0] = breakdown[i];
            String checkStr = new String(check);
            if (i % 2 == 0) {

                sb.append(checkStr.toUpperCase());
            } else {
                sb.append(checkStr.toLowerCase());
            }
        }

        return sb.toString();
    }
}
